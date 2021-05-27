variable "sg_name" {
  type = string
  description = "Name of security group"
}

variable "vpc_id" {
  type = string
  description = "VPC ID where security group will live"
}

variable "inbound_rules" {
  type = map(object({
    from_port = string
    to_port = string
    protocol = string
    cidr_block = list(string)
    self = bool
  }))
  description = "A list of inbound rules to attach to the security group, all fields of the map need to be populated"
}

variable "tags" {
  type = map(string)
  description = "List of tags to add to resource"
}