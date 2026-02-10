resource "aws_cloudwatch_log_group" "lambda_orders" {
  name              = "/aws/lambda/${var.project}-ORDERS-${var.environment}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda_products" {
  name              = "/aws/lambda/${var.project}-PRODUCTS-${var.environment}"
  retention_in_days = 7
}

# Security Group for Lambda
resource "aws_security_group" "lambda" {
  name        = "${var.project}-lambda-sg-${var.environment}"
  description = "Security group for Lambda functions"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-lambda-sg-${var.environment}"
  }
}

# Lambda Functions
resource "aws_lambda_function" "users" {
  filename         = "${path.module}/dist/users.zip"
  function_name    = "${var.project}-USERS-${var.environment}"
  role            = aws_iam_role.lambda_execution.arn
  handler         = "bootstrap"
  source_code_hash = data.archive_file.users.output_base64sha256
  runtime         = "provided.al2023"
  timeout         = 30
  memory_size     = 256
  architectures   = ["x86_64"]

  vpc_config {
    subnet_ids         = data.aws_subnets.default.ids
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      DB_HOST     = aws_db_instance.products.address
      DB_PORT     = "5432"
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = "products"
    }
  }
}

resource "aws_lambda_function" "products" {
  filename         = "${path.module}/dist/products.zip"
  function_name    = "${var.project}-PRODUCTS-${var.environment}"
  role            = aws_iam_role.lambda_execution.arn
  handler         = "bootstrap"
  source_code_hash = data.archive_file.products.output_base64sha256
  runtime         = "provided.al2023"
  timeout         = 30
  memory_size     = 256
  architectures   = ["x86_64"]

  vpc_config {
    subnet_ids         = data.aws_subnets.default.ids
    security_group_ids = [aws_security_group.lambda.id]
  }

  environment {
    variables = {
      DB_HOST     = aws_db_instance.products.address
      DB_PORT     = "5432"
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = "products"
    }
  }
}

# Lambda Permissions for API Gateway
resource "aws_lambda_permission" "users" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
}

resource "aws_lambda_permission" "products" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.products.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
}
