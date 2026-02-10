# RDS PostgreSQL Instance (Free Tier eligible)
resource "aws_db_instance" "products" {
  identifier             = lower("${var.project}-products-${var.environment}")
  engine                 = "postgres"
  engine_version         = "17.5"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  max_allocated_storage  = 20
  storage_type           = "gp2"
  db_name                = "products"
  username               = var.db_username
  password               = var.db_password
  backup_retention_period = 7
  skip_final_snapshot     = true
  publicly_accessible     = true
  
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name        = "${var.project}-products-${var.environment}"
    Environment = var.environment
  }
}

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = lower("${var.project}-db-subnet-${var.environment}")
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "${var.project}-db-subnet-${var.environment}"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds" {
  name        = "${var.project}-rds-sg-${var.environment}"
  description = "Security group for RDS"
  vpc_id      = data.aws_vpc.default.id

  # Allow Lambda functions to connect
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda.id]
  }

  # Allow public access for database initialization and development
  # WARNING: In production, restrict this to specific IPs
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow public PostgreSQL access (dev only)"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-sg-${var.environment}"
  }
}
