data "aws_vpc" "pond_vpc" {
  id = "vpc-009e668fa4cb4d349"  # ID der Sandbox vpc
}

variable "subnet_id_eur_cent_1" {
  description = "The ID of the public subnet to use for the ECS service."
  type        = string
}

