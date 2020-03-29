resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "marina-codepipeline-1"
  acl    = "private"
}