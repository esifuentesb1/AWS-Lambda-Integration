resource "aws_s3_bucket" "this" {
  bucket = "${var.project}-${var.env}-images"
}
resource "aws_s3_bucket_notification" "notify" {
  bucket = aws_s3_bucket.this.id
  queue {
    queue_arn     = var.sqs_queue_arn
    events        = ["s3:ObjectCreated:*"]
  }
}