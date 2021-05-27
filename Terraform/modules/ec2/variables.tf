variable "private_subnet_ids" {
  type = list(string)
  description = "A list of the private subnet ids where there Swarm EC2 Nodes will live"
}

variable "ec2_name" {
  type = string
  description = "Name of EC2/EC2-groups, If Multiple EC2, name will get a prefix per EC2"
}

variable "ec2_instance_type" {
  type = string
  description = "Type for the EC2 instances, https://aws.amazon.com/ec2/instance-types/"
}

variable "instance_ips" {
  type = list(string)
  description = "List of ip address to attach to ec2"
}

variable "instance_profile_name" {
  type = string
  description = "The Name of the IAM instance profile created, Needed to be able to SSM into EC2"
}

variable "number_of_instances" {
  type = number
  description = "The number on EC2 needed to created"
}

variable "user_data" {
  type = string
  description = "The user data script that will get run on EC2 first creation, eg: cloud-init script"
}

variable "security_group_ids" {
  type = list(string)
  description = "List of security group ids to attach to EC2"
}

variable "tags" {
  type = map(string)
  description = "List of tags to add to resource"
}