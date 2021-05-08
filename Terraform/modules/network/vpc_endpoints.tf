resource "aws_vpc_endpoint" "ssm" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.ssm"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids = module.vpc.private_subnets
}

resource "aws_vpc_endpoint" "ssm-messages" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.eu-west-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids = module.vpc.private_subnets
}