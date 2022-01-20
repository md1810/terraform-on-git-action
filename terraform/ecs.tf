# ecs.tf

resource "aws_ecs_cluster" "main" {
  count = var.ecs_cluster_already_exists ? 0 : 1
  name  = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }

}

# data "template_file" "myapp" {
#   template = file("${var.ecs_task_definition_container_definitions_file_path}")

#   vars = {
#     app_image        = var.app_image
#     container_port   = var.container_port
#     fargate_cpu      = var.fargate_cpu
#     fargate_memory   = var.fargate_memory
#     aws_region       = var.aws_region
#     container_name   = var.container_name
#     ecs_service_name = var.ecs_service_name
#   }
# }

# resource "aws_ecs_task_definition" "app" {
#   family                   = var.ecs_task_definition_name
#   execution_role_arn       = var.task_execution_role_arn
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = var.fargate_cpu
#   memory                   = var.fargate_memory
#   container_definitions    = data.template_file.myapp.rendered
#   container_definitions    = jsonencode([
#     {
#       name      = "first"
#       image     = "nginx:latest"
#       cpu       = 10
#       memory    = 512
#       essential = true
#       portMappings = [
#         {
#           containerPort = 80
#           hostPort      = 80
#         }
#       ]
#     },
#     {
#       name      = "second"
#       image     = "nginx:latest"
#       cpu       = 10
#       memory    = 256
#       essential = true
#       portMappings = [
#         {
#           containerPort = 443
#           hostPort      = 443
#         }
#       ]
#     }
#   ])

#   volume {
#     name      = "service-storage"
#     host_path = "/ecs/service-storage"
#   }

#   placement_constraints {
#     type       = "memberOf"
#     expression = "attribute:ecs.availability-zone in [eu-west-1a, eu-west-1b]"
#   }
# }


resource "aws_ecs_service" "main" {
  name            = var.ecs_service_name
  cluster         = var.ecs_cluster_already_exists ? var.ecs_cluster_arn_no : aws_ecs_cluster.main[0].id
  task_definition = var.ecs_task_definition_arn
  #task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    # security_groups  = [aws_security_group.ecs_tasks.id]
    security_groups  = var.ecs_task_security_group_id
    subnets          = var.private_subnets
    assign_public_ip = false
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_alb_listener.front_end_https]
}