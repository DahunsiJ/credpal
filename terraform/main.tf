module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
}

module "rds" {
  source      = "./modules/rds"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

module "alb" {
  source      = "./modules/alb"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
}

module "ecs" {
  source      = "./modules/ecs"
  environment = var.environment
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
  alb_arn     = module.alb.alb_arn
  image_url   = "ghcr.io/<YOUR_GITHUB_USERNAME>/credpal-node-app:latest"
}
