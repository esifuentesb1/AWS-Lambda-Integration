resource "aws_s3_bucket" "this" {
  bucket = "${var.project}-${var.env}-images"
}

resource "aws_s3_bucket_notification" "notify" {
  bucket = aws_s3_bucket.this.id

  depends_on = [
    aws_sqs_queue_policy.allow_s3
  ]

  queue {
    queue_arn = aws_sqs_queue.main.arn
    events    = ["s3:ObjectCreated:*"]
  }
}