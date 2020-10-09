services = {
  "web0" : {
    id      = "web0"
    name    = "web"
    address = "172.31.43.78"
    port    = 80
    meta = {
      mac_address = "00:00:00:00:01:00"
    }
    tags            = ["dc1", "nginx", "test", "web"]
    namespace       = null
    status          = "passing"
    node            = "i-08040820d8d7c4984"
    node_id         = "63844302-407d-5cc6-a618-a9e5caad1d1f"
    node_address    = "172.31.43.78"
    node_datacenter = "us-east-1"
    node_tagged_addresses = {
      lan      = "172.31.43.78"
      lan_ipv4 = "172.31.43.78"
      wan      = "172.31.43.78"
      wan_ipv4 = "172.31.43.78"
    }
    node_meta = {
      consul-network-segment = ""
    }
  },
  "web3" : {
    id      = "web3"
    name    = "web"
    address = "192.168.128.17"
    port    = 80
    meta = {
      mac_address = "00:00:00:00:02:00"
    }
    tags            = ["dc1", "nginx", "test", "web"]
    namespace       = null
    status          = "passing"
    node            = "i-0d61132ea5ad3c0bf"
    node_id         = "d7d41dc5-7b60-3dbb-0537-6abcf453daa9"
    node_address    = "172.31.94.1"
    node_datacenter = "us-east-1"
    node_tagged_addresses = {
      lan      = "172.31.94.1"
      lan_ipv4 = "172.31.94.1"
      wan      = "172.31.94.1"
      wan_ipv4 = "172.31.94.1"
    }
    node_meta = {
      consul-network-segment = ""
    }
  },
  "web1" : {
    id      = "web1"
    name    = "web"
    address = "172.31.51.85"
    port    = 80
    meta = {
      mac_address = "00:00:00:00:03:00"
    }
    tags            = ["dc1", "nginx", "test", "web"]
    namespace       = null
    status          = "passing"
    node            = "i-0f92f7eb4b6fb460a"
    node_id         = "778506df-a1b2-65e0-fe1e-eafd2d1162a8"
    node_address    = "172.31.51.85"
    node_datacenter = "us-east-1"
    node_tagged_addresses = {
      lan      = "172.31.51.85"
      lan_ipv4 = "172.31.51.85"
      wan      = "172.31.51.85"
      wan_ipv4 = "172.31.51.85"
    }
    node_meta = {
      consul-network-segment = ""
    }
  }
}