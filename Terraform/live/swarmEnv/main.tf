provider "aws" {
  region = local.region
  profile = "piroddicloud"
}

locals {
  region = "eu-west-1"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.14, < 0.15"

  backend "s3" {
    bucket = "euw1-dockercon-terraform-state"
    key = "live/swarmEnv/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "dockercon-terraform-state"
    encrypt = true
  }
}

module "network" {
  source = "../../modules/network"

  cidr_range = "10.0.0.0/16"
  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "iam" {
  source = "../../modules/IAM"
  instance_profile_name = "Docker-swarm-ssm"
}

module "master" {
  source = "../../modules/ec2"

  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-master"
  instance_profile_name = module.iam.instance_profile_name
  user_data_file_path = "${path.module}/master-script.sh"
  private_subnet_id = module.network.private_subnets[0]
  instance_ip = "10.0.1.5"
}

module "node1" {
  depends_on = [time_sleep.wait_120_seconds]
  source = "../../modules/ec2"

  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-node1"
  instance_profile_name = module.iam.instance_profile_name
  user_data_file_path = "${path.module}/node-script.sh"
  private_subnet_id = module.network.private_subnets[1]
  instance_ip = "10.0.2.5"
}

module "node2" {
  depends_on = [time_sleep.wait_120_seconds]
  source = "../../modules/ec2"

  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-node2"
  instance_profile_name = module.iam.instance_profile_name
  user_data_file_path = "${path.module}/node-script.sh"
  private_subnet_id = module.network.private_subnets[2]
  instance_ip = "10.0.3.5"
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [module.master]
  create_duration = "125s"
}
