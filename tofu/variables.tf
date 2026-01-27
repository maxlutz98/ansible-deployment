variable "pm_api_url" {
    type = string
    description = "Proxmox Host API URL"
}
variable "pm_api_token_id" {
    type = string
    description = "Proxmox Host API Token ID"
}
variable "pm_api_token_secret" {
    type = string
    description = "Proxmox Host API Token Secret"
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
