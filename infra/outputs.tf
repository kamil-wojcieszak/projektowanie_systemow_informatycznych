output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.main.id
}

output "api_gateway_url" {
  description = "API Gateway endpoint URL"
  value       = aws_apigatewayv2_stage.main.invoke_url
}

output "s3_bucket_name" {
  description = "S3 bucket name for static files"
  value       = aws_s3_bucket.static_files.id
}

output "lambda_function_names" {
  description = "Names of deployed Lambda functions"
  value = {
    users    = aws_lambda_function.users.function_name
    products = aws_lambda_function.products.function_name
    orders   = aws_lambda_function.orders.function_name
  }
}
