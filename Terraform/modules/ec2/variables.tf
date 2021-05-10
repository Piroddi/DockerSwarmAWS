variable "private_subnet_ids" {
  type = list(string)
}

variable "ec2_name" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "instance_ips" {
  type = list(string)
}

variable "instance_profile_name" {
  type = string
}

variable "number_of_instances" {
  type = number
}

variable "user_data" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}