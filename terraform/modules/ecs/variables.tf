variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to deploy ECS service"
}

variable "security_group_id" {
  type        = string
  description = "Security group for ECS tasks"
}

variable "target_group_arn" {
  type        = string
  description = "ALB target group ARN for ECS service"
}

variable "image_url" {
  type        = string
  description = "Docker image URL for ECS task"
}

variable "cpu" {
  type        = string
  default     = "256"
}

variable "memory" {
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  type        = string
}

variable "task_role_arn" {
  type        = string
}
