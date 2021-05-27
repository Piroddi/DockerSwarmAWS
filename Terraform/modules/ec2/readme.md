## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ec2\_instance\_type | Type for the EC2 instances, https://aws.amazon.com/ec2/instance-types/ | `string` | n/a | yes |
| ec2\_name | Name of EC2/EC2-groups, If Multiple EC2, name will get a prefix per EC2 | `string` | n/a | yes |
| instance\_ips | List of ip address to attach to ec2 | `list(string)` | n/a | yes |
| instance\_profile\_name | The Name of the IAM instance profile created, Needed to be able to SSM into EC2 | `string` | n/a | yes |
| number\_of\_instances | The number on EC2 needed to created | `number` | n/a | yes |
| private\_subnet\_ids | A list of the private subnet ids where there Swarm EC2 Nodes will live | `list(string)` | n/a | yes |
| security\_group\_ids | List of security group ids to attach to EC2 | `list(string)` | n/a | yes |
| tags | List of tags to add to resource | `map(string)` | n/a | yes |
| user\_data | The user data script that will get run on EC2 first creation, eg: cloud-init script | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ids | List of IDs of instances |

