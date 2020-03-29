
resource "aws_codebuild_project" "project" {
  name          = var.project
  description   = "${var.project} CodeBuild Project"
  build_timeout = "10"
  service_role  = aws_iam_role.codebuild_role.arn

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:1.0"
    type         = "LINUX_CONTAINER"
  }
  
  cache {
    type     = "S3"
    location = "${aws_s3_bucket.target.bucket}/cache/archives"
  }
  
  artifacts {
    type = "CODEPIPELINE"
    packaging = "ZIP"
    override_artifact_name = "false"
  }

 

  source {
    type = "CODEPIPELINE"
    buildspec = <<BUILDSPEC
version: 0.2

env:
  variables:
    key: "value"

phases:
  install:
    runtime-versions:
      java: openjdk8
    commands:
      - apt-get update -y
      - apt-get install -y maven
      
  build:
    commands:
      - echo Build started on `date`
      - mvn test
  pre_build:
    commands:
      - echo This is pre_build
  build:
    commands:
      - echo Starting build `date`
      - mvn clean package
      - echo $CODEBUILD_SRC_DIR
  post_build:
    commands:
      - echo Build completed on `date`
artifacts:
    base-directory: $CODEBUILD_SRC_DIR 
    files:
      - target/springboot-rds-appointment-0.0.1-SNAPSHOT.jar   

  
BUILDSPEC    
  }


}




