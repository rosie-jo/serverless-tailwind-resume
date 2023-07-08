# cloudfront OAC

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "OAC-${var.domain}-${random_string.random_suffix.result}-${var.domain}"
  description                       = ""
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


# Create CloudFront distribution

resource "aws_cloudfront_distribution" "my_distribution" {
  depends_on = [aws_acm_certificate_validation.validation]

  # origin for the s3
  origin {
    domain_name              = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.my_bucket.id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  # origin for the api gateway
  origin {
	domain_name = replace(aws_api_gateway_deployment.deployment.invoke_url, "/^https?://([^/]*).*/", "$1")
	origin_id   = "apigw"

	custom_origin_config {
		http_port              = 80
		https_port             = 443
		origin_protocol_policy = "https-only"
		origin_ssl_protocols   = ["TLSv1.2"]
	}
}

ordered_cache_behavior {
	path_pattern     = "/prod/*"
	allowed_methods  = ["GET", "HEAD"]
	cached_methods   = ["GET", "HEAD"]
	target_origin_id = "apigw"

	default_ttl = 0
	min_ttl     = 0
	max_ttl     = 0

	forwarded_values {
		query_string = true
		cookies {
			forward = "all"
		}
	}

	viewer_protocol_policy = "redirect-to-https"
}

  aliases = ["${var.domain}", "www.${var.domain}"]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution made by terraform"
  default_root_object = "index.html"


  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.my_bucket.id
    viewer_protocol_policy = "redirect-to-https" # other options - https only, http
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }


  tags = {
    Environment = "CldRsmChllng"
  }

}

