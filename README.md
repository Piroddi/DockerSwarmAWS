# Docker Swarm - A journey to the cloud 
This repository contains the source code and architecture diagrams for the infrastructure and application demonstrated in the talk presented by Kelvin Piroddi and Lukonde Mwila at DockerCon 2021.

## Overview
### Infrastructure
All the infrastructure components demonstrated in the Docker Swarm in AWS diagram below are created using Terraform. This includes the networking components such as the VPC, the Subnets, the Network Load Balancer, the EC2 instances used for the managers and the workers, and their respective Security Groups. 

### Microservice Application
The microservice application consists of 3 services, a GraphQL service which acts as the gateway to the products and orders services. All services are in Node.JS to Kelvin's dismay. The application is a very basic example of ecommerce components. Each service is containerised with Docker. The microservices has a docker-compose.yaml folder at the root which is used to deploy the stack onto the Docker Swarm cluster.

## Docker Swarm in AWS
![Alt text](./Docker-Swarm-AWS.jpg?raw=true "Docker Swarm in AWS Diagram")

## Swarm Ingress
![Alt text](./Swarm-ingress.jpg?raw=true "Swarm Ingress Diagram")
