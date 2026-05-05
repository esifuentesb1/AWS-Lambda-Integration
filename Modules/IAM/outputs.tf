output "upload_role_arn" {
  value = aws_iam_role.upload.arn
}

output "crop_role_arn" {
  value = aws_iam_role.crop.arn
}