output "ids" {
 description = "List of IDs of instances"
 value       = module.ec2.*.id
}