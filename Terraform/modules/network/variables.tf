variable "cidr_range" {
  type = string
  description = "The cidr range for new vpc, eg: 10.0.0.0/16"
}

variable "azs" {
  type = list(string)
  description = "The list of az to crate you subnets in"
}

variable "private_subnets" {
  type = list(string)
  description = "List of private subnets needed, with each subnet the cidr range being value in list"
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnets needed, with each subnet the cidr range being value in list"
}

variable "security_group_ids" {
  type = list(string)
  description = "Security group ids added to the VPC endpoints created in this module"
}

variable "region" {
  type = string
  description = "Where to deploy the network resources"
}

variable "tags" {
  type = map(string)
  description = "List of tags to add to resource"
}