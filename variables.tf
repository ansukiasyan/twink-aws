variable "server_port" {
  description = "ec2 instance port for HTTP requests"
  type        = number
  default     = 80
}

variable "ssh_key" {
    description = "ssh public key"
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrrXHX5hDyxdfUyoW3ReZg9P7UwEwZfrRBlqM/3UK34cJxKzBLjfKWvP8c43urx+L6igP4yAz+EbCWzHXVqS94EmdjiXLkvdT+9/Zn+ZaiAe2lFXQ6H2dqkgq1/ZeC4Qlb6CoCFSQYgcfp2yTFM8drUStQpWvRupOE+STdaRtxvlBynno2QlKr7DbTFDS9L3ylvPzCRtiXrCjIPRerhy1GhZE5Vb0f76Z5ZV7yDxNvti2XUBir21uP2lt2mQBSvWDK9GZaxQ5Z7xmvgeSfwaVk194GHtk8ZdECYX9jEx0GGqJXqhgEJFJ37ujLWP5Amb/C5UOEWhbVbOh1cTBdUFvz annas@AMYW-AnnaS"
}