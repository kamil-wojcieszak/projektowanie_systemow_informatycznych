# Data sources
data "aws_caller_identity" "current" {}

# Archive Lambda functions
data "archive_file" "users" {
  type        = "zip"
  source_dir  = "${path.module}/../lambdas/users/dist"
  output_path = "${path.module}/dist/users.zip"
}

data "archive_file" "products" {
  type        = "zip"
  source_dir  = "${path.module}/../lambdas/products/dist"
  output_path = "${path.module}/dist/products.zip"
}

data "archive_file" "orders" {
  type        = "zip"
  source_dir  = "${path.module}/../lambdas/orders/dist"
  output_path = "${path.module}/dist/orders.zip"
}
