
resource "proxmox_vm_qemu" "alpine-test" {
  name        = var.vm_name
  vmid        = var.vm_id
  target_node = var.vm_target_node

  clone      = "alpine-cloud"
  full_clone = true
  os_type    = "cloud-init"

  start_at_node_boot = var.vm_start_at_node_boot

  agent = 1
  scsihw = "virtio-scsi-single"
  boot        = "order=scsi0"
  vm_state    = "running"
  automatic_reboot = true
  tablet = false

  cpu { 
    cores = var.vm_cpu_cores 
    sockets = 1 
    type = "host"
  }
  balloon = var.vm_balloon
  memory = var.vm_memory

  serial {
    id = 0
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-zfs"
          size    = var.vm_disk_size 
          iothread = true
          discard = true
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "local-zfs"
        }
      }
    }
  }

  ciupgrade = true
  sshkeys   = file("${var.vm_ssh_key_file}")
  ipconfig0 = "ip=${var.vm_ip},gw=${var.vm_gateway}"

  lifecycle {    
    ignore_changes = [
      clone,
      full_clone
    ]
  }
}
