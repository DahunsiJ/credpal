variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Public subnets for ALB"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS"
}

variable "security_group_id" {
  type        = string
  description = "Security group for ALB"
}
