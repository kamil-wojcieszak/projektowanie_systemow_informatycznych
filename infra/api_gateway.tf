# CloudWatch Log Group for API Gateway
resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/${var.project}-API-${var.environment}"
  retention_in_days = 7
}

# API Gateway
resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project}-API-${var.environment}"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = var.cors_allowed_origins
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization"]
    max_age       = 300
  }
}

resource "aws_apigatewayv2_stage" "main" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = var.environment
  auto_deploy = true
}

# Lambda Integrations
resource "aws_apigatewayv2_integration" "users" {
  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.users.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "products" {
  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.products.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_integration" "orders" {
  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.orders.invoke_arn
  payload_format_version = "2.0"
}

# API Routes
resource "aws_apigatewayv2_route" "users" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /users/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.users.id}"
}

resource "aws_apigatewayv2_route" "products" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /products/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.products.id}"
}

resource "aws_apigatewayv2_route" "orders" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /orders/{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.orders.id}"
}
