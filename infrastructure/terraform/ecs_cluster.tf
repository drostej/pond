resource "aws_ecs_cluster" "nginx_cluster" {
  name = "nginx-cluster"
}

resource "aws_ecs_task_definition" "nginx_task" {
  family                   = "nginx-td"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = <<DEFINITION
[
  {
    "name": "nginx-container",
    "image": "<aws_account_id>.dkr.ecr.<region>.amazonaws.com/nginx-pond:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

