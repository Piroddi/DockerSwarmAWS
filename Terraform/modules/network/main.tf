module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Docker-Swarm"
  cidr = var.cidr_range

  azs = var.azs
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets

  enable_nat_gateway = true

  public_subnet_tags = {
    Name = "Docker-Swarm-public"
  }

  tags = {
    Environment = "DockerCon"
  }

  enable_dns_hostnames = true
  enable_dns_support = true

  vpc_tags = {
    Name = "Docker-Swarm"
    Environment = "DockerCon"
  }
}