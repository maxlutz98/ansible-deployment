variable "ssh_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCaJIQpRrvg71wwTn/MtObS3bIpLT3Es/MU8u+1ne/iAt6M/y647ne+UH95Hx0pb+GElgyzhqXRqr2KvdZWjSIiIBRlYn/4KPiEPuX+yqUvWJnCdFhsYEnZweQ+c0T0u+YmeERi+CcqST6bPDVkHTDD//pa75pMZCr6XchYWqfwloU6mhnKuYkE4541Zu82zmHBDP4lNb9u5vQgQLdPWs1FIduKEuQpAq631HzjLUH9f7YZy8J7ywObRQhXBA0xrTbaGMsxJO9hDbpwgOfRTDbg1VxL5YtOnJ6z4pLiSut75YsPbkefCjfI5ANk5Y2THc8GTu0N5qFPW2uVbWk8aLaf Maximilian@Maxi-MacBook.local"
}
variable "api_url" {
    default = "https://192.168.200.20:8006/api2/json" 
}
variable "proxmox_host" {
    default = "blackpanther"
}
variable "template_name" {
  default = "debian11-cloud"
}
variable "token_id" {
  default = "terraform@pam!terraform_token_id"
}
variable "token_secret" {
  default = "b83a54df-4bd3-477f-9245-e1d9c94d2131"
}
