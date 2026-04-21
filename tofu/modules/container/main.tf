
locals {
  os_templates = {
    "alpine" = proxmox_file.latest_alpine_3_23_container_template.id
    "debian" = proxmox_file.latest_debian_13_trixie_container_template.id
  }
}

resource "proxmox_virtual_environment_container" "ubuntu_container" {
  description = "Managed by Terraform"

  node_name = var.container_target_node
  vm_id     = var.container_id

  start_on_boot = var.container_start_at_node_boot

  # newer linux distributions require unprivileged user namespaces
  unprivileged = true
  features {
    nesting = true
    keyctl  = true
  }

  cpu {
    cores = var.container_cpu_cores
  }

  memory {
    dedicated = var.container_memory
  }

  initialization {
    hostname = var.container_name

    ip_config {
      ipv4 {
        address = var.container_ip
        gateway = var.container_ip == "dhcp" ? null : var.container_gateway
      }
    }

    user_account {
      keys     = [trimspace(file("${var.container_ssh_key_file}"))]
      password = random_password.container_password.result
    }
  }

  network_interface {
    bridge = "vmbr0"
    name   = "eth0"
  }

  disk {
    datastore_id = "local-zfs"
    size         = var.container_disk_size
  }

  operating_system {
    template_file_id = local.os_templates[var.container_os]
    type             = var.container_os
  }
}

data "proxmox_file" "latest_alpine_3_23_container_template" {
  node_name    = "pve"
  datastore_id = "local"
  content_type = "vztmpl"
  file_name    = "alpine-3.23-default_20260116_amd64.tar.xz"
}

data "proxmox_file" "latest_debian_13_trixie_container_template" {
  node_name    = "pve"
  datastore_id = "local"
  content_type = "vztmpl"
  file_name    = "debian-13-standard_13.1-2_amd64.tar.zst"
}

resource "random_password" "container_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

output "container_password" {
  value     = random_password.container_password.result
  sensitive = true
}
