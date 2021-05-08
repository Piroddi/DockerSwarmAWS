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
    key = "live/dev/network/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "dockercon-terraform-state"
    encrypt = true
  }
}

module "network" {
  source = "../../../modules/network"
}