## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| inbound\_rules | A list of inbound rules to attach to the security group, all fields of the map need to be populated | <pre>map(object({<br>    from_port = string<br>    to_port = string<br>    protocol = string<br>    cidr_block = list(string)<br>    self = bool<br>  }))</pre> | n/a | yes |
| sg\_name | Name of security group | `string` | n/a | yes |
| tags | List of tags to add to resource | `map(string)` | n/a | yes |
| vpc\_id | VPC ID where security group will live | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_id | n/a |

