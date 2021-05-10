locals {
  number_of_managers = 3
  number_of_nodes = 3
  initial_manager_ip = "10.0.1.5"
  region = "eu-west-1"
  tags = {
    Name = "Docker-Swarm"
    Project = "DockerCon"
    Team = "Kelvin-Piroddi-Lukonde Mwila"
    Description = "Docker-Swarm-A-journey-to-the-cloud"
  }
  sg_inbound_rules = {
    swarm-1 = {
      from_port = "2377"
      to_port = "2377"
      protocol = "tcp"
      cidr_block = null
      self = true
    }
    swarm-2 = {
      from_port = "7946"
      to_port = "7946"
      protocol = "tcp"
      cidr_block = null
      self = true
    },
    swarm-3 = {
      from_port = "7946"
      to_port = "7946"
      protocol = "udp"
      cidr_block = null
      self = true
    },
    swarm-4 = {
      from_port = "4789"
      to_port = "4789"
      protocol = "udp"
      cidr_block = null
      self = true
    },
    nlb = {
      from_port = "80"
      to_port = "80"
      protocol = "tcp"
      cidr_block = [module.network.vpc_cidr_block]
      self = false
    }
  }
}