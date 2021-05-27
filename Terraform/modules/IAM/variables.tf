variable "instance_profile_name" {
  type = string
  description = "The name of the instance profile. Role has been preassigned the IAM policies needed"
}

variable "tags" {
  type = map(string)
  description = "List of tags to add to resource"
}