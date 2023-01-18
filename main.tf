provider "aws" {
  region = "us-east-1"
}


module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "python_function"
  description   = "My awesome lambda function"
  handler       = "project.lambda_handler"
  runtime       = "python3.8"
  attach_policy_json = true
  policy_json   = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:ListBucket", "s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  source_path = "${path.module}/python/"
}

module "s3-bucket_example_complete" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  bucket  = "lade-sbucket"
}
