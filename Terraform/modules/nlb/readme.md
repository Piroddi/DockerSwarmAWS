## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| nlb\_name | The name of the NLB | `string` | n/a | yes |
| public\_subnet\_ids | List of public subnets to attach the load balancer too | `list(string)` | n/a | yes |
| tags | List of tags to add to resource | `map(string)` | n/a | yes |
| target\_group\_port | The port that the NLB will forward traffic to | `string` | n/a | yes |
| vpc\_id | The VPC id to deploy load balancer in | `string` | n/a | yes |
| worker\_node\_ips | List of EC2 ids that the load balancer will load balance :) | `list(string)` | n/a | yes |
| worker\_node\_port | Port that the NLB will listen on | `string` | n/a | yes |

## Outputs

No output.

