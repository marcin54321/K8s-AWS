variable "master_instance_count" {
  default     = "1"
}

variable "worker_instance_count" {
  default     = "1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "public_key" {
  default = "~/.ssh/MyKeyPair.pub"
}

variable "private_key" {
  default = "~/.ssh/MyKeyPair.pem"
}

variable "ansible_user" {
  default = "ubuntu"
}

variable "ami" {
  default = "ami-0e0102e3ff768559b"
}
