
variable "container_name" {
  type        = string
  description = "Name der container in Proxmox"
}
variable "container_id" {
  type        = number
  description = "ID der container in Proxmox"
}
variable "container_target_node" {
  type        = string
  description = "Node to deploy the container to"
}
variable "container_cpu_cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 1
}
variable "container_memory" {
  type        = number
  description = "Amount of memory in MB"
  default     = 512
}
variable "container_start_at_node_boot" {
  type        = bool
  description = "If the container should be started on boot of the host"
  default     = false
}
variable "container_disk_size" {
  type        = number
  description = "Size of the container disk in GB"
  default     = 4
}
variable "container_ssh_key_file" {
  type        = string
  description = "Path to the SSH key file"
}
variable "container_ip" {
  type        = string
  description = "IP address of the container"
  default     = "dhcp"
}
variable "container_gateway" {
  type        = string
  description = "Gateway of the container"
  default     = null
}

variable "container_os" {
  type        = string
  description = "The operating system to use for the container (e.g., alpine, debian)"
  default     = "alpine"
  validation {
    condition     = contains(["alpine", "debian"], var.container_os)
    error_message = "The container_os must be either 'alpine' or 'debian'."
  }
}
