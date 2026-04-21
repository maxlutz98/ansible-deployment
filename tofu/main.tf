locals {
  default_gateway      = "192.168.200.1"
  default_ssh_key_file = "~/.ssh/id_rsa.pub"
  vms = {
    alpine-test = {
      vm_os                 = "alpine"
      vm_target_node        = var.target_node
      vm_id                 = 910
      vm_cpu_cores          = 2
      vm_memory             = 2048
      vm_balloon            = 1024
      vm_disk_size          = 8
      vm_ssh_key_file       = local.default_ssh_key_file
      vm_start_at_node_boot = true
      vm_ip                 = "192.168.200.133/32"
      vm_gateway            = local.default_gateway
    }
  }
  containers = {
    alpine-lxc-test = {
      container_os                 = "alpine"
      container_target_node        = var.target_node
      container_id                 = 810
      container_cpu_cores          = 1
      container_memory             = 512
      container_disk_size          = 8
      container_ssh_key_file       = local.default_ssh_key_file
      container_start_at_node_boot = false
      container_ip                 = "dhcp"
      container_gateway            = null
    }
  }
}


module "vms" {
  for_each = local.vms

  source = "./modules/vm"

  vm_name               = each.key
  vm_os                 = each.value.vm_os
  vm_id                 = each.value.vm_id
  vm_target_node        = each.value.vm_target_node
  vm_cpu_cores          = each.value.vm_cpu_cores
  vm_memory             = each.value.vm_memory
  vm_balloon            = each.value.vm_balloon
  vm_disk_size          = each.value.vm_disk_size
  vm_ssh_key_file       = each.value.vm_ssh_key_file
  vm_start_at_node_boot = each.value.vm_start_at_node_boot
  vm_ip                 = each.value.vm_ip
  vm_gateway            = each.value.vm_gateway
}

module "containers" {
  for_each = local.containers

  source = "./modules/container"

  container_name               = each.key
  container_os                 = each.value.container_os
  container_id                 = each.value.container_id
  container_target_node        = each.value.container_target_node
  container_cpu_cores          = each.value.container_cpu_cores
  container_memory             = each.value.container_memory
  container_disk_size          = each.value.container_disk_size
  container_ssh_key_file       = each.value.container_ssh_key_file
  container_start_at_node_boot = each.value.container_start_at_node_boot
  container_ip                 = each.value.container_ip
  container_gateway            = each.value.container_gateway
}

output "vm_ipv4_addresses" {
  description = "Die IP-Adressen der erstellten VMs"
  value       = { for k, v in module.vms : k => v.vm_ipv4_address }
}

output "container_passwords" {
  description = "Die Passwörter der erstellten Container"
  value       = { for k, v in module.containers : k => v.container_password }
  sensitive   = true
}
