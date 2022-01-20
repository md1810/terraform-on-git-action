# alb.tf

resource "aws_alb" "main" {
  name            = var.alb_name
  subnets         = var.public_subnets
  security_groups = var.alb_security_group_id
}

resource "aws_alb_target_group" "app" {
  name        = var.first_taget_group_name
  port        = var.app_port
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "5"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_target_group" "app_2" {
  name        = var.second_taget_group_name
  port        = var.app_port
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "5"
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "5"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the 80 to 443
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end_https" {
  load_balancer_arn = aws_alb.main.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.https_certificate_arn

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}