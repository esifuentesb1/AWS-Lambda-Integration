resource "aws_lambda_function" "upload" {
  function_name = "${var.project}-${var.env}-upload"
  role          = var.upload_role
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  filename         = "${path.module}/upload.zip"
  source_code_hash = filebase64sha256("${path.module}/upload.zip")

  environment {
    variables = {
      BUCKET = var.bucket_name
    }
  }
}

resource "aws_lambda_function" "crop" {
  function_name = "${var.project}-${var.env}-crop"
  role          = var.crop_role
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  filename         = "${path.module}/crop.zip"
  source_code_hash = filebase64sha256("${path.module}/crop.zip")

  environment {
    variables = {
      BUCKET = var.bucket_name
    }
  }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.queue_arn
  function_name    = aws_lambda_function.crop.arn
  batch_size       = 1
}