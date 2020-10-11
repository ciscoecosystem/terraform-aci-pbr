locals {
  service_as_key             = transpose({ for id, s in var.services : id => [s.name] })
  service_view               = { for id, s in var.services : id => { id = id, ip = (var.services[id].address == "" ? var.services[id].node_address : var.services[id].address), mac = s.meta.mac_address } }
  service_group_output       = { for name, ids in local.service_as_key : name => [for id in ids : local.service_view[id]] }
  service_payload            = [for _, s in var.services : s]
  synthetic_payload          = [for s in local.service_payload : merge(s, { service_redirection_policy = format("%s-%s-svc", var.service_redirection_policy_prefix, s.name) })]
  service_redirection_output = { for v in distinct(values(aci_service_redirect_policy.this)) : v.name => v.id }
}

data "aci_tenant" "this" {
  name = var.tenant_name
}

resource "aci_service_redirect_policy" "this" {
  for_each              = { for _, policy in distinct([for s in local.synthetic_payload : s.service_redirection_policy]) : policy => policy }
  tenant_dn             = data.aci_tenant.this.id
  name                  = each.value
  dest_type             = "L3"
  hashing_algorithm     = "sip-dip-prototype"
  threshold_down_action = "deny"
}

resource "aci_destination_of_redirected_traffic" "this" {
  for_each                   = { for _, s in local.synthetic_payload : s.id => s }
  dest_name                  = each.value.id
  service_redirect_policy_dn = aci_service_redirect_policy.this[each.value.service_redirection_policy].id
  ip                         = each.value.address == "" ? each.value.node_address : each.value.address
  mac                        = each.value.meta.mac_address
}
