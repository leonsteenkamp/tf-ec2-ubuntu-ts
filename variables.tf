# variables.tf

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "terraformInstance"
}

variable "private_key_path" {
  type      = string
  # sensitive = true
}

variable "public_key_path" {
  type      = string
  # sensitive = true
}

variable "ssh_user" {
  type      = string
  # sensitive = true
}

variable "aws_region" {
  type      = string
  # sensitive = true
}

variable "instance_type" {
  type = string
  # t4g.micro is an arm64 instance
  default = "t4g.micro"
}

variable "instance_arch" {
  type    = string
  default = "arm64"
  # default = "amd64"
}

variable "ssh_src_ip" {
  type      = string
  sensitive = true
}
