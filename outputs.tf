output "acm" {
  value = aws_acm_certificate.certificate.id
}

output "dns_cf_value" {
  value = aws_route53_record.cloudfront_record.alias
}
output "dns_cf_name" {
  value = aws_route53_record.cloudfront_record.name
}

output "cf_origin" {
  value = aws_cloudfront_distribution.my_distribution.domain_name
}

output "validation" {
  value = [for record in aws_route53_record.dns_ssl_validation : record.fqdn]
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
