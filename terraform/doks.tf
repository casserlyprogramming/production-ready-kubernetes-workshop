variable "do_token" {}

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.19.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "workshop-cluster" {
  name   = "workshop-cluster"
  # Find and change the value to an availble datacenter region close to you
  # See DO datacenter regions with the command doctl compute region list
  region = "lon1"
  auto_upgrade = true
  # Grab the latest DO Kubernetes version slug
  # See the available versions with the command doctl kubernetes options versions
  version = "1.22.11-do.0"
  ha = true

  node_pool {
    name       = "workshop-node"
    # This is a Basic AMD Droplet with 2 vCPUs and 4GB RAM
    # show droplet sizes with the command doctl compute size list
    size       = "s-2vcpu-4gb-amd"
    auto_scale = true
    min_nodes  = 3
    max_nodes  = 5
  }
}
