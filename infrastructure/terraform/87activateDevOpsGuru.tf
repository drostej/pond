resource "aws_devopsguru_resource_collection" "aws_devops_guru" {
  count = var.aws_devops_guru_enabled ? 1 : 0
  type  = "AWS_SERVICE"
  cloudformation {
    stack_names = ["*"]
  }
}
