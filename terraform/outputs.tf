output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "alb_dns_name" {
  value = module.alb.dns_name
}
