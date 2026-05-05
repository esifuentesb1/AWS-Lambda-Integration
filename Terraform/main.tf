module "sqs" {
  source  = "../Modules/sqs"
  env     = var.env
  project = var.project
}

module "S3" {
  source     = "../Modules/S3"
  env        = var.env
  project    = var.project
  sqs_queue_arn = module.sqs.queue_arn
}

module "iam" {
  source  = "../Modules/iam"
  env     = var.env
  project = var.project
  bucket  = module.S3.bucket_name
}

module "lambda" {
  source  = "../Modules/lambda"
  env     = var.env
  project = var.project

  bucket_name = module.S3.bucket_name
  queue_arn   = module.sqs.queue_arn

  upload_role = module.iam.upload_role_arn
  crop_role   = module.iam.crop_role_arn
}

module "apigateway" {
  source  = "../Modules/apigateway"
  env     = var.env
  project = var.project

  lambda_arn        = module.lambda.upload_arn
  lambda_invoke_arn = module.lambda.upload_invoke_arn
}