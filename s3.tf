# Create S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  //"1a6lfd-${var.domain}"
  bucket = "1a6lfd-${var.domain}"
  tags = {
    Environment = "CldRsmChllng"
  }
}

data "aws_iam_policy_document" "allow_access_to_s3" {
  statement {
    sid = "AllowCloudFrontServicePrincipalRead"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.my_bucket.arn}/*",
    ]

    condition {
      test     = "StringLike"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.my_distribution.arn
      ]
    }
  }

  depends_on = [
    aws_s3_bucket.my_bucket
  ]
}


resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = data.aws_iam_policy_document.allow_access_to_s3.json
}
