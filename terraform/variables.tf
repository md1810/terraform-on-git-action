# variables.tf
# ECS_CODEdeploy_terraform
#arn:aws:iam::874724229473:role/ECS_CODEdeploy_terraform

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "eu-west-1"
}


variable "https_certificate_arn" {
  description = "Domain certificate for https"
  default     = "arn:aws:acm:eu-west-1:078053088323:certificate/aab654c8-7be2-4e30-9a59-8db8009fed87"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster, Do not enter logz.io image"
  default     = "nginx:latest"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 443
}

variable "container_name" {
  description = "Enter the container name, Do not enter logz.io container name"
  default     = "test-nginx"
  type        = string
}

variable "container_insights" {
  description = "Controls if ECS Cluster has container insights enabled"
  type        = bool
  default     = false
}

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to, Do not enter logz.io container port"
  default     = 3001
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "vpc_id" {
  description = "Insert the VPC ID"
  default     = "vpc-004106d4c6c646b02"
  type        = string
}

variable "public_subnets" {
  description = "Enter the public subnets IDs for alb"
  default     = ["subnet-00db7f26fdfd2de1f","subnet-091f15e0b521e9520"]
  type        = list(string)
}

variable "private_subnets" {
  description = "Enter the private subnets IDs for ecs"
  default     = ["subnet-03586fd76f2a6eb67","subnet-0600933172647541b"]
  type        = list(string)
}

variable "alb_name" {
  description = "Enter the ALB Name"
  default     = "terraform-alb-test"
  type        = string
}

variable "alb_security_group_id" {
  description = "Enter the alb security group ID."
  default     = ["sg-0df28990270b48f87"]
  type        = list(string)
}

variable "first_taget_group_name" {
  description = "Enter the First Target Group Name"
  default     = "terraform-target-group-1"
  type        = string
}

variable "second_taget_group_name" {
  description = "Enter the Second Target Group Name"
  default     = "terraform-target-group-2"
  type        = string
}

variable "code_deploy_app_name" {
  description = "Enter the Code Deploy app Name"
  default     = "terraform-test"
  type        = string
}

variable "code_deployment_group_name" {
  description = "Enter the Code Deployment group Name"
  default     = "terraform-test"
  type        = string
}

variable "code_deploy_ecs_role_arn" {
  description = "Enter the Code deploy IAM role arn"
  default     = "arn:aws:iam::078053088323:role/Ecs_task_executionRole"
  type        = string
}

variable "ecs_cluster_already_exists" {
  description = "Enter true if Cluster already created else false."
  default     = false
  type        = bool
}

variable "ecs_task_definition_arn" {
  description = "Task defination arn (exsting)"
  default     = "arn:aws:ecs:eu-west-1:078053088323:task-definition/task-nginx"
  type        = string
}

variable "ecs_cluster_arn_no" {
  description = "Enter the ECS Cluster ARN No if ecs_cluster_already_exists is true else ignore this variable."
  default     = false
  type        = string
}

variable "ecs_cluster_name" {
  description = "Enter the ECS Cluster Name."
  default     = "terraform-test-without-cluster"
  type        = string
}

variable "ecs_task_definition_name" {
  description = "Enter the ECS Task Defination Name"
  default     = "terraform-task-test"
  type        = string
}

variable "task_execution_role_arn" {
  description = "Enter the ECS Task execution role arn"
  default     = "arn:aws:iam::078053088323:role/Ecs_task_executionRole"
  type        = string
}

variable "ecs_task_definition_container_definitions_file_path" {
  description = "Add the container definitions full file path"
  default     = "./templates/ecs/avenews.json.tpl"
  type        = string
}

variable "ecs_service_name" {
  description = "Enter the ECS service Name"
  default     = "API-env-stage"
  type        = string
}

variable "ecs_task_security_group_id" {
  description = "Enter the ecs task security group id."
  default     = ["sg-0df28990270b48f87"]
  type        = list(string)
}
