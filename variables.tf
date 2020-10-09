variable "services" {
  description = "Consul services monitored by Consul NIA"
  type = map(
    object({
      id        = string
      name      = string
      address   = string
      port      = number
      status    = string
      meta      = map(string)
      tags      = list(string)
      namespace = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)
    })
  )
}

variable "username" {}
variable "url" {}
variable "private_key" {}
variable "cert_name" {}
variable "tenant_name" {}
variable "service_redirection_policy_name" {}
