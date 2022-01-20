
resource "aws_codedeploy_app" "my-app" {
  compute_platform = "ECS"
  name             = var.code_deploy_app_name
}

resource "aws_codedeploy_deployment_group" "example" {
  app_name               = aws_codedeploy_app.my-app.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.code_deployment_group_name
  service_role_arn       = var.code_deploy_ecs_role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 0
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_already_exists ? var.ecs_cluster_name : aws_ecs_cluster.main[0].name
    service_name = aws_ecs_service.main.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_alb_listener.front_end_https.arn]
      }

      target_group {
        name = aws_alb_target_group.app.name
      }

      target_group {
        name = aws_alb_target_group.app_2.name
      }
    }
  }
}