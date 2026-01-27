terraform {
  backend "local" {
    path = "state/proxmox.tfstate"
  }
}
