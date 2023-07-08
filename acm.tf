resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.dns_ssl_validation : record.fqdn]
}

resource "aws_acm_certificate" "certificate" {
  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "DNS"
  tags = {
    "Project"   = "cldRsmChllng"
    "ManagedBy" = "Terraform"
  }

}






