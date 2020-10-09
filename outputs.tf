output "workload_pool" {
  value = { for id, s in var.services : s.id => [s.name, (s.address == "" ? s.node_address : s.address), s.meta.mac_address] }
}