provider "aws" {
  region = local.region
}

locals {
  region = "eu-west-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Docker-Swarm"
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "Docker-Swarm-public"
  }

  tags = {
    Environment = "DockerCon"
  }

  enable_dns_hostnames = true
  enable_dns_support = true
  enable_nat_gateway = true

  vpc_tags = {
    Name = "Docker-Swarm"
    Environment = "DockerCon"
  }
}