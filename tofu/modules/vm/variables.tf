
variable "vm_name" {
    type = string
    description = "Name der VM in Proxmox"
}
variable "vm_id" {
    type = number
    description = "ID der VM in Proxmox"
}
variable "vm_target_node" {
    type = string
    description = "Node to deploy the VM to"
}
variable "vm_cpu_cores" {
  type = number
  description = "Number of CPU cores"  
}
variable "vm_memory" {
  type = number
  description = "Amount of memory in MB" 
}
variable "vm_balloon" {
  type = number
  description = "Minimum amount of memory in MB for ballooning"
}
variable "vm_start_at_node_boot" {
  type = bool
  description = "If the VM should be started on boot of the host"
  default = false
}
variable "vm_disk_size" {
  type = string
  description = "Size of the VM disk"
}
variable "vm_ssh_key_file" {
  type = string
  description = "Path to the SSH key file"
}
variable "vm_ip" {
  type = string
  description = "IP address of the VM"
}
variable "vm_gateway" {
  type = string
  description = "Gateway of the VM"
}
