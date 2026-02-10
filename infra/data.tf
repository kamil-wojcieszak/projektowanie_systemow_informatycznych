# Data sources
data "aws_caller_identity" "current" {}

# Archive Lambda functions
data "archive_file" "users" {
  type        = "zip"
  source_file = "${path.module}/../deployments/UsersApi/bootstrap"
  output_path = "${path.module}/dist/users.zip"
}

data "archive_file" "products" {
  type        = "zip"
  source_file = "${path.module}/../deployments/ProductsApi/bootstrap"
  output_path = "${path.module}/dist/products.zip"
}
