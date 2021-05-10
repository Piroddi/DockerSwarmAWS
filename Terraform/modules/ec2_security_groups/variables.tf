variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "inbound_rules" {
  type = map(object({
    from_port = string
    to_port = string
    protocol = string
    cidr_block = list(string)
    self = bool
  }))
}