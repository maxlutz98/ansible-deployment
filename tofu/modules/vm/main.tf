resource "proxmox_virtual_environment_vm" "this" {
  name      = var.vm_name
  node_name = var.vm_target_node
  vm_id = var.vm_id

  clone {
    vm_id = 9400
    full  = true
  }

  on_boot = var.vm_start_at_node_boot

  tablet_device = false

  scsi_hardware = "virtio-scsi-single"

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
    trim = true
  }

  cpu {
    cores = var.vm_cpu_cores
    type = "host"
  }

  memory {
    dedicated = var.vm_memory
    floating   = var.vm_balloon
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-zfs"
    interface    = "scsi0"
    iothread     = true
    discard      = "on"
    size         = var.vm_disk_size
  }

  serial_device {}

  initialization {
    datastore_id = "local-zfs"
    ip_config {
      ipv4 {
        address = var.vm_ip
        gateway = var.vm_gateway
      }
    }

    user_account {
      # keys     = [trimspace(data.local_file.ssh_public_key.content)]
      keys     = [trimspace(file("${var.vm_ssh_key_file}"))]
    }
  }
}

output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.this.ipv4_addresses[1][0]
}