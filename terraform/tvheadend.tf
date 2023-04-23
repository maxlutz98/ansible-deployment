resource "proxmox_vm_qemu" "tvheadend" {
  count = 1
  name = "tvheadend2"
  target_node = var.proxmox_host

  vmid = 110
  full_clone = true
  desc = "tvheadend machine"

  clone = var.template_name
  agent = 1
  onboot = true
  os_type = "cloud-init"
  cores = 1
  sockets = 1
  cpu = "host"
  memory = 1024
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
  
  ipconfig0 = "ip=192.168.200.30/24,gw=192.168.200.1"
  ipconfig1 = "ip=192.168.200.31/24,gw=192.168.200.1"
  ipconfig2 = "ip=192.168.200.32/24,gw=192.168.200.1"
  
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}