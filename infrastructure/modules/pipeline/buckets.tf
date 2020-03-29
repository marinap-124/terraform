resource "aws_s3_bucket" "target" {
  bucket        = "marina-codepipeline-2"
  acl           = "private"
  force_destroy = true

  tags = {
    Environment   = terraform.workspace
    Terraform   = "true"
  }
}