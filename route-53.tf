# pointing to the hosted zone 
data "aws_route53_zone" "hosted_zone" {
  name         = var.domain
  private_zone = false
}

# cloudfront DNS record 
resource "aws_route53_record" "cloudfront_record" {

  name    = var.domain
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.my_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.my_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

# www DNS record 
resource "aws_route53_record" "sub_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.sub_domain
  type    = "CNAME"
  ttl     = 300

  records = [var.domain]
}

resource "aws_route53_record" "test_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "test.${var.domain}"
  type    = "CNAME"
  ttl     = 300

  records = [var.domain]
}

# SSL validation 

resource "aws_route53_record" "dns_ssl_validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }


    if length(regexall("\\*\\..+", dvo.domain_name)) > 0
  }


  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 300
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hosted_zone.id
}



