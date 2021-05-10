resource "aws_security_group" "instance-security-groups" {
  name = "${var.sg_name}-SG"
  description = "Security group attached to all Swarm instances"
  vpc_id = var.vpc_id


  dynamic "ingress" {
    for_each = var.inbound_rules
    content {
      from_port = ingress.value.from_port
      protocol = ingress.value.protocol
      to_port = ingress.value.to_port
      self = ingress.value.self
      cidr_blocks = ingress.value.cidr_block

    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}