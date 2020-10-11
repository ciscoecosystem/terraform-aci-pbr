locals {
  #Transposing map to get service name as key and service instances as attributes
  service_as_key             = transpose({ for id, s in var.services : id => [s.name] })
  service_view               = { for id, s in var.services : id => { id = id, ip = (var.services[id].address == "" ? var.services[id].node_address : var.services[id].address), mac = s.meta.mac_address } }
  #Format module output to provide service instance information
  service_group_output       = { for name, ids in local.service_as_key : name => [for id in ids : local.service_view[id]] }
  
  service_payload            = [for _, s in var.services : s]
  #Compute new cts service block, adding ACI specific information to it. This enables for_each meta argument to loop through ACI and cts data within the same resource block.
  synthetic_payload          = [for s in local.service_payload : merge(s, { service_redirection_policy = format("%s-%s-svc", var.service_redirection_policy_prefix, s.name) })]
  
  #Format module output to map the created service(s) (name) to ACI service redirection object(s) (Dn)
  service_redirection_output = { for v in distinct(values(aci_service_redirect_policy.this)) : v.name => v.id }
}

data "aci_tenant" "this" {
  name = var.tenant_name
}

resource "aci_service_redirect_policy" "this" {
  #Loop through the list of unique services that need to be created
  for_each              = { for _, policy in distinct([for s in local.synthetic_payload : s.service_redirection_policy]) : policy => policy }
  tenant_dn             = data.aci_tenant.this.id
  name                  = each.value
  dest_type             = "L3"
  hashing_algorithm     = "sip-dip-prototype"
  threshold_down_action = "deny"
}

resource "aci_destination_of_redirected_traffic" "this" {
  #Loop through the list of compute instances and map them to the corresponding service redirection policy and associated VIP
  for_each                   = { for _, s in local.synthetic_payload : s.id => s }
  dest_name                  = each.value.id
  service_redirect_policy_dn = aci_service_redirect_policy.this[each.value.service_redirection_policy].id
  ip                         = each.value.address == "" ? each.value.node_address : each.value.address
  mac                        = each.value.meta.mac_address
}
