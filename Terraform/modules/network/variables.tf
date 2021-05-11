variable "cidr_range" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "region" {
  type = string
}