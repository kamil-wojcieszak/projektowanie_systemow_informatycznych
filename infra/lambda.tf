# CloudWatch Log Groups for Lambdas
resource "aws_cloudwatch_log_group" "lambda_users" {
  name              = "/aws/lambda/${var.project}-USERS-${var.environment}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda_products" {
  name              = "/aws/lambda/${var.project}-PRODUCTS-${var.environment}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda_orders" {
  name              = "/aws/lambda/${var.project}-ORDERS-${var.environment}"
  retention_in_days = 7
}

# Lambda Functions
resource "aws_lambda_function" "users" {
  filename         = "${path.module}/dist/users.zip"
  function_name    = "${var.project}-USERS-${var.environment}"
  role            = aws_iam_role.lambda_execution.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.users.output_base64sha256
  runtime         = "nodejs22.x"
  timeout         = 30
  memory_size     = 128
}

resource "aws_lambda_function" "products" {
  filename         = "${path.module}/dist/products.zip"
  function_name    = "${var.project}-PRODUCTS-${var.environment}"
  role            = aws_iam_role.lambda_execution.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.products.output_base64sha256
  runtime         = "nodejs22.x"
  timeout         = 30
  memory_size     = 128
}

resource "aws_lambda_function" "orders" {
  filename         = "${path.module}/dist/orders.zip"
  function_name    = "${var.project}-ORDERS-${var.environment}"
  role            = aws_iam_role.lambda_execution.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.orders.output_base64sha256
  runtime         = "nodejs22.x"
  timeout         = 30
  memory_size     = 128
}

# Lambda Permissions for API Gateway
resource "aws_lambda_permission" "users" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.users.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}

resource "aws_lambda_permission" "products" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.products.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}

resource "aws_lambda_permission" "orders" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.orders.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
