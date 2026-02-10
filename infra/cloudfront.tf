# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "static_files" {
  name                              = "${var.project}-OAC-${var.environment}"
  description                       = "OAC for static files bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.project}-DISTRIBUTION-${var.environment}"
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  # S3 origin for static files
  origin {
    domain_name              = aws_s3_bucket.static_files.bucket_regional_domain_name
    origin_id                = "S3-${aws_s3_bucket.static_files.id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.static_files.id
  }

  # Default behavior - serve static files
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${aws_s3_bucket.static_files.id}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }
}
