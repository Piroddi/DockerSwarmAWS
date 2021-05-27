resource "aws_lb" "swarm" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnet_ids

  tags = var.tags
}

resource "aws_lb_target_group" "swarm-nodes" {
  name        = "Docker-Swarm-Nodes"
  port        = var.target_group_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_target_group_attachment" "swarm" {
  count = length(var.worker_node_ips)
  target_group_arn = aws_lb_target_group.swarm-nodes.arn
  target_id        = var.worker_node_ips[count.index]
  port             = var.worker_node_port
}

resource "aws_lb_listener" "swarm-nodes" {
  load_balancer_arn = aws_lb.swarm.arn
  port              = "80"
  protocol = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.swarm-nodes.arn
  }
}