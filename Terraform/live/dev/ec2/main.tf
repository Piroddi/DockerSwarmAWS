provider "aws" {
  region = "eu-west-1"
  profile = "piroddicloud"
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
    key = "live/dev/ec2/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "dockercon-terraform-state"
    encrypt = true
  }
}

module "network" {
  source = "../../../modules/ec2"
  private_ip_list = ["10.0.3.5"]
  private_subnet_id = "subnet-00b6c05d13c7582f1"
}