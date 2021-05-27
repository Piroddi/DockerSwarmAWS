## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azs | The list of az to crate you subnets in | `list(string)` | n/a | yes |
| cidr\_range | The cidr range for new vpc, eg: 10.0.0.0/16 | `string` | n/a | yes |
| private\_subnets | List of private subnets needed, with each subnet the cidr range being value in list | `list(string)` | n/a | yes |
| public\_subnets | List of public subnets needed, with each subnet the cidr range being value in list | `list(string)` | n/a | yes |
| region | Where to deploy the network resources | `string` | n/a | yes |
| security\_group\_ids | Security group ids added to the VPC endpoints created in this module | `list(string)` | n/a | yes |
| tags | List of tags to add to resource | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azs | A list of availability zones spefified as argument to this module |
| nat\_public\_ips | List of public Elastic IPs created for AWS NAT Gateway |
| private\_subnets | List of IDs of private subnets |
| public\_subnets | List of IDs of public subnets |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_id | The ID of the VPC |

