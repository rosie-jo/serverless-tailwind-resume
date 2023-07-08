
resource "aws_iam_role" "lambda_role" {
  name               = "${var.domain}-${random_string.random_suffix.result}-terraform_aws_lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# IAM policy for logging from a lambda


resource "aws_iam_role_policy_attachment" "attach_AmazonDynamoDBFullAccess_iam" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

  ])
  role       = aws_iam_role.lambda_role.name
  policy_arn = each.value

}


# Generates an archive from content, a file, or a directory of files.
data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/dist/python_count_script.zip"
}

# Create a lambda function
# In terraform ${path.module} is the current directory.
resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/dist/python_count_script.zip"
  function_name = "rosie-jo-${random_string.random_suffix.result}-viewer-count-func"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
}




