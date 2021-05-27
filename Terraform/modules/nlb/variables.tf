variable "vpc_id" {
  type = string
  description = "The VPC id to deploy load balancer in"
}

variable "target_group_port" {
  type = string
  description = "The port that the NLB will forward traffic to"
}

variable "worker_node_ips" {
  type = list(string)
  description = "List of EC2 ids that the load balancer will load balance :) "
}

variable "worker_node_port" {
  type = string
  description = "Port that the NLB will listen on"
}

variable "nlb_name" {
  type = string
  description = "The name of the NLB"
}
variable "public_subnet_ids" {
  type = list(string)
  description = "List of public subnets to attach the load balancer too"
}

variable "tags" {
  type = map(string)
  description = "List of tags to add to resource"
}