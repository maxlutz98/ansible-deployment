locals {
  vms = {
    alpine-test = {
      vm_target_node        = var.target_node
      vm_id                 = 910
      vm_cpu_cores          = 2
      vm_memory             = 2048
      vm_balloon            = 1024
      vm_disk_size          = 8
      vm_ssh_key_file       = "~/.ssh/id_rsa.pub"
      vm_start_at_node_boot = true
      vm_ip                 = "192.168.200.133/32"
      vm_gateway            = "192.168.200.1"
    }
  }
}



module "vms" {
  for_each = local.vms

  source = "./modules/vm"

  vm_name     = each.key
  vm_id       = each.value.vm_id
  vm_target_node = each.value.vm_target_node
  vm_cpu_cores = each.value.vm_cpu_cores
  vm_memory   = each.value.vm_memory
  vm_balloon  = each.value.vm_balloon
  vm_disk_size = each.value.vm_disk_size
  vm_ssh_key_file = each.value.vm_ssh_key_file
  vm_start_at_node_boot = each.value.vm_start_at_node_boot
  vm_ip = each.value.vm_ip
  vm_gateway = each.value.vm_gateway
}
