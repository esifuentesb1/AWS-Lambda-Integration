output "upload_arn" {
  value = aws_lambda_function.upload.arn
}

output "upload_invoke_arn" {
  value = aws_lambda_function.upload.invoke_arn
}