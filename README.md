# Docker Swarm - A Journey to the AWS Cloud 
This repository contains the source code and architecture diagrams for the infrastructure and application demonstrated in the talk presented by Kelvin Piroddi and Lukonde Mwila at DockerCon 2021.

## Container Orchestration
As great as they are, it's not enough to containerize your applications if you don't have a system that enables you to automatically fulfill the following:
Deploying images and containers
- Integrate and orchestrate these modular parts
- Managing the scaling of containers and clusters based on the demand
- Resource balancing in containers and clusters
- Provide communication across a cluster
- Traffic management for services

Containers, unfortunately, don't inherently accomplish all this for you. They are merely pieces that require a crane, like DockerSwarm, to fulfill the orchestration responsibilities.<br /><br />
Container orchestration automates the scheduling, deployment, networking, scaling, health monitoring, and management of containers. If you have ever tried to manually scale your deployments to maximize efficiency or secure your applications consistently across platforms, you have already experienced many of the pains a container orchestration platform can help solve. 

## Project Overview
### Infrastructure
All the infrastructure components demonstrated in the Docker Swarm in AWS diagram below are created using Terraform. This includes the networking components such as the VPC, the Subnets, the Network Load Balancer, the EC2 instances used for the managers and the workers, and their respective Security Groups. <br /><br />
The EC2 instances that make up the cluster are deployed to private subnets in the VPC. Since the nodes to have access to the Internet for installation of dependencies, a NAT Gateway is deployed to the public subnets to allow traffic from the Internet to reach the private nodes. 

The application is accessible through an NLB associated with the public subnets and forwards incoming traffic to the nodes in the private subnets on the relevant port for the application. 

### Microservice Application
The microservice application consists of 3 services, a GraphQL service which acts as the gateway to the products and orders services. All services are in Node.JS to Kelvin's dismay. The application is a very basic example of ecommerce components. Each service is containerised with Docker. 

#### Docker Compose Config File
The microservices has a docker-compose.yaml file at the root. This is the configuration file which is used to define images used for the container serivices, as well as describe how the different containers should run when deployed. This file can be used to spin up the services locally using the following command: 
```
docker-compose up
```
This same configuration file is also used to deploy the stack onto the Docker Swarm cluster using the following command: 
```
docker stack deploy --compose-file <docker-compose-file>
```
Details of how this file is uploaded and used for the stack can be seen in the swarm-init.yaml file in the Terraform/live/swarmEnv folder. The images for each of the services are stored in Kelvin's public repository on DockerHub. You can make use of these or build your own and push to your own repository. If you make changes to application locally and want to test the services, you can uncomment the build configuration to point to the local Dockerfiles to rebuild the application with the relevant changes.

```
version: '3.9'
services:
  graphql-bff-server-api:
    image: 'piroddi/swarm-services-graphql-bff:latest'
    #build:
    #  context: ./graphql-bff
    #  dockerfile: Dockerfile
    deploy:
      mode: replicated
      replicas: 3
    ports:
      - '3002:3002'
    restart: on-failure
    container_name: graphql-bff-server-api
    environment:
      ORDERS_SERVICE_PORT: orders-api:3003
      PRODUCTS_SERVICE_PORT: products-api:3004
  orders-api:
    image: 'piroddi/swarm-services-orders:latest'
    #build:
    #  context: ./orders
    #  dockerfile: Dockerfile
    deploy:
      mode: replicated
      replicas: 3
    ports:
      - '3003:3003'
    restart: on-failure
    container_name: orders
  products-api:
    image: 'piroddi/swarm-services-products:latest'
    #build:
    #  context: ./products
    #  dockerfile: Dockerfile
    deploy:
      mode: replicated
      replicas: 3
    ports:
      - '3004:3004'
    restart: on-failure
    container_name: products
```

## Docker Swarm in AWS
![Alt text](./Docker-Swarm-AWS.jpg?raw=true "Docker Swarm in AWS Diagram")

## Swarm Ingress
![Alt text](./Swarm-ingress.jpg?raw=true "Swarm Ingress Diagram")
