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

resource "aws_network_interface" "private" {
  subnet_id   = var.private_subnet_id
  private_ips = var.private_ip_list

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "ece" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name = "Swarm-master"
  }

  network_interface {
    network_interface_id = aws_network_interface.private.id
    device_index = 0
  }

  iam_instance_profile = aws_iam_role.ssm_instance_profile.name
}