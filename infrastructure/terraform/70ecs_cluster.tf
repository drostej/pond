resource "aws_ecs_cluster" "nginx_cluster" {
  name = "nginx-cluster"
}

resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.nginx_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [var.subnet_id_eur_cent_1]  # Ersetze dies mit einem öffentlichen Subnetz
    security_groups = [aws_security_group.nginx_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_ecs_task_definition.nginx_task]
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
    "image": "537124936702.dkr.ecr.eu-central-1.amazonaws.com/pond-ecr-repo:latest",
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

