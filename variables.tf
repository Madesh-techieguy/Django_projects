variable "server_host" {
  type        = string
  description = "IP or hostname of the server"
  default     = "213.210.36.103"
}

variable "server_user" {
  type        = string
  description = "SSH user"
  default     = "root"
}

variable "server_password" {
  type        = string
  description = "SSH password"
  sensitive   = true
  default = "aLONaniCKylE@23"
}

variable "app_dir" {
  type        = string
  description = "Directory on server where app will live"
  default     = "/var/opt/myproject"  
}

variable "repo_url" {
  type        = string
  description = "Git repo URL of your Django+Docker project"
  default     = "https://github.com/Madesh-techieguy/Django_projects.git"
}
