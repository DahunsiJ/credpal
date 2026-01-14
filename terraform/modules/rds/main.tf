resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-db-subnets"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  identifier          = "${var.environment}-db"
  engine              = "postgres"
  engine_version      = "16.1"
  instance_class      = var.instance_class
  name                = var.db_name
  username            = var.username
  password            = var.password
  allocated_storage   = 20
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.security_group_id]
  skip_final_snapshot = true
  publicly_accessible = false
}
