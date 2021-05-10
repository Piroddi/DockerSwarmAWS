resource "aws_lb" "test" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  tags = var.tags
}

resource "aws_lb_target_group" "swarm-nodes" {
  name        = "Docker-Swarm-Nodes"
  port        = var.target_group_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "test" {
  count = var.worker_node_ids
  target_group_arn = aws_lb_target_group.swarm-nodes.vpc_id
  target_id        = count.index
  port             = var.worker_node_port
}