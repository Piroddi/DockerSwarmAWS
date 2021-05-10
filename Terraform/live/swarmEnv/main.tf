provider "aws" {
  region = local.region
  profile = "piroddicloud"
}

locals {
  region = "eu-west-1"
  tags = {
    Name = "Docker-Swarm"
    Project = "DockerCon"
    Team = "Kelvin Piroddi & Lukonde Mwila"
    Description = "Docker Swarm - A journey to the cloud"
  }
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

module "nlb" {
  source = "../../modules/nlb"
  nlb_name = "Docker-Swarm"
  public_subnet_ids = module.network.public_subnets
  tags = local.tags
  target_group_port = "80"
  vpc_id = module.network.vpc_id
  worker_node_ids = [""]
  worker_node_port = "80"
}

module "iam" {
  source = "../../modules/IAM"
  instance_profile_name = "Docker-swarm-ssm"
}

data "template_file" "user_data" {
  template = file("${path.module}/swarm-init.yaml")
  vars = {
    initial-master-ip = "10.0.1.5"
    initial-master = true
    worker = false
  }
}

module "masters" {

  depends_on = [module.network]
  number_of_instances = 1

  source = "../../modules/ec2"
  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-master"
  instance_profile_name = module.iam.instance_profile_name
  private_subnet_id = module.network.private_subnets[0]
  instance_ips = ["10.0.1.5", "10.0.2.5", "10.0.3.5"]
  user_data = data.template_file.user_data.rendered
}

module "nodes" {
  depends_on = [time_sleep.wait_120_seconds]
  source = "../../modules/ec2"

  number_of_instances = 3
  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-node"
  instance_profile_name = module.iam.instance_profile_name
  user_data_file_path = "${path.module}/node-script.sh"
  private_subnet_id = module.network.private_subnets[1]
  instance_ips = ["10.0.1.6", "10.0.2.6", "10.0.3.6"]

  user_data = ""
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [module.master]
  create_duration = "120s"
}

