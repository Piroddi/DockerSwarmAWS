data "template_file" "initial-manager" {
  template = file("${path.module}/swarm-init.yaml")
  vars = {
    initial-manager-ip = local.initial_manager_ip
    initial-manager = true
    docker-compose-b64 = filebase64("../../../microservices/docker-compose.yaml")
    worker = false
    new-manager = false
  }
}

data "template_file" "managers" {
  template = file("${path.module}/swarm-init.yaml")
  vars = {
    initial-manager-ip = local.initial_manager_ip
    initial-manager = false
    worker = false
    new-manager = true
  }
}

data "template_file" "nodes" {
  template = file("${path.module}/swarm-init.yaml")
  vars = {
    initial-manager-ip = local.initial_manager_ip
    initial-manager = false
    worker = true
    new-manager = false
  }
}