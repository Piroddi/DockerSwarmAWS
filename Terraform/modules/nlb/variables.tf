variable "vpc_id" {
  type = string
}

variable "target_group_port" {
  type = string
}

variable "worker_node_ips" {
  type = list(string)
}

variable "worker_node_port" {
  type = string
}

variable "nlb_name" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}