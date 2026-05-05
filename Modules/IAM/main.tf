resource "aws_iam_role" "upload" {
  name = "${var.project}-${var.env}-upload-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "upload_policy" {
  role = aws_iam_role.upload.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = ["s3:PutObject"],
      Resource = "${var.bucket}/*"
    }]
  })
}

resource "aws_iam_role" "crop" {
  name = "${var.project}-${var.env}-crop-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "crop_policy" {
  role = aws_iam_role.crop.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:PutObject"],
        Resource = "${var.bucket}/*"
      },
      {
        Effect = "Allow",
        Action = ["sqs:*"],
        Resource = "*"
      }
    ]
  })
}