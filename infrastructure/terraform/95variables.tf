data "aws_vpc" "pond_vpc" {
  id = "vpc-0a59e06dbd3297c94"  # ID der Sandbox vpc
}

variable "subnet_id_eur_cent_1" {
  description = "The ID of the public subnet to use for the ECS service."
  type        = string
}

##-----------------------------------------------------------------------------
## DevOps Guru resource collection
##-----------------------------------------------------------------------------
variable "aws_devops_guru_enabled" {
  type        = bool
  default     = false
  description = "Enable DevOps Guru resource collection for this account in this region"
}