provider "aws" {
  region = local.region
  profile = "piroddicloud"
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  required_version = ">= 0.15, < 0.16"

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

module "sg" {
  source = "../../modules/ec2_security_groups"
  inbound_rules = local.sg_inbound_rules
  sg_name = "Swarm"
  vpc_id = module.network.vpc_id
}

module "initial_manager" {
  source = "../../modules/ec2"
  number_of_instances = 1

  ec2_instance_type = "t2.micro"
  ec2_name = "Initial-Manager"
  instance_profile_name = module.iam.instance_profile_name
  private_subnet_ids = module.network.private_subnets
  instance_ips = [local.initial_manager_ip]
  user_data = data.template_file.initial-manager.rendered
  security_group_ids = [module.sg.security_group_id]
}

module "managers" {

  depends_on = [module.initial_manager]
  source = "../../modules/ec2"
  number_of_instances = (local.number_of_managers - 1)

  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-Manager"
  instance_profile_name = module.iam.instance_profile_name
  private_subnet_ids = [module.network.private_subnets[1],module.network.private_subnets[2]]
  instance_ips = ["10.0.2.5", "10.0.3.5"]
  user_data = data.template_file.managers.rendered
  security_group_ids = [module.sg.security_group_id]
}

module "nodes" {
  depends_on = [module.managers]
  source = "../../modules/ec2"

  number_of_instances = local.number_of_nodes
  ec2_instance_type = "t2.micro"
  ec2_name = "Swarm-Node"
  instance_profile_name = module.iam.instance_profile_name
  private_subnet_ids = module.network.private_subnets
  instance_ips = ["10.0.1.6", "10.0.2.6", "10.0.3.6"]
  user_data = data.template_file.nodes.rendered
  security_group_ids = [module.sg.security_group_id]
}

module "nlb" {
  depends_on = [module.nodes]

  source = "../../modules/nlb"
  nlb_name = "Docker-Swarm"
  public_subnet_ids = module.network.public_subnets
  tags = local.tags
  target_group_port = "80"
  vpc_id = module.network.vpc_id
  worker_node_ips = ["10.0.1.6", "10.0.2.6", "10.0.3.6"]
  worker_node_port = "3002"
}


