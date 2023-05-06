resource "proxmox_vm_qemu" "monitoring" {
  count = 2
  name = "monitoring"
  target_node = var.proxmox_host

  vmid = 100
  full_clone = true
  desc = "machine containing administration and monitoring tools"

  clone = var.template_name
  agent = 1
  onboot = true
  os_type = "cloud-init"
  cores = 1
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"
  disk {
    slot = 0
    size = "8G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 1
  }
  
  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  
  ipconfig0 = "ip=192.168.200.21/24,gw=192.168.200.1"
  
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}