variable "pm_endpoint" {
    type = string
    description = "Proxmox Host endpoint"
}
variable "pm_api_token" {
    type = string
    description = "Proxmox API token"
}

variable "vm_name" {
    type = string
    description = "Name der VM in Proxmox"
}
variable "vm_id" {
    type = number
    description = "ID der VM in Proxmox"
}
variable "target_node" {
    type = string
    description = "Node to deploy the VM to"
}
variable "vm_template_name" {
    type = string
    description = "Name of the template to use for the VM"
}
