resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = var.security_group_ids
  subnet_ids = module.vpc.private_subnets
}

resource "aws_vpc_endpoint" "ssm-messages" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = var.security_group_ids
  subnet_ids = module.vpc.private_subnets
}

# ECR
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets

  security_group_ids = var.security_group_ids
}


resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = module.vpc.private_subnets

  security_group_ids = var.security_group_ids
}