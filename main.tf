data "aci_tenant" "this" {
  name = var.tenant_name
}

resource "aci_service_redirect_policy" "this" {
  tenant_dn             = data.aci_tenant.this.id
  name                  = var.service_redirection_policy_name
  dest_type             = "L3"
  hashing_algorithm     = "sip-dip-prototype"
  threshold_down_action = "deny"
}

resource "aci_destination_of_redirected_traffic" "this" {
  for_each                   = var.services
  dest_name                  = each.value.id
  service_redirect_policy_dn = aci_service_redirect_policy.this.id
  ip                         = each.value.address == "" ? each.value.node_address : each.value.address
  mac                        = each.value.meta.mac_address
}
