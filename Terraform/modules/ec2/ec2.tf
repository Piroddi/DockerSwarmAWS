data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  count = var.number_of_instances
  use_num_suffix = true

  ami = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  name = var.ec2_name

  iam_instance_profile = var.instance_profile_name
  subnet_id = var.private_subnet_id
  user_data = var.user_data
  private_ips = var.instance_ips
}

