




resource "aws_codepipeline" "codepipeline" {
  name     = "marina-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn


  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
}
    

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner  = "marinap-124"
        OAuthToken = "a9e99d7ee2cbd86036a2ce174c5027e92781a172"
        Repo   = "springboot-rds-appointment"
        Branch = "master"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "springboot-rds-appointment"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        RoleArn        = aws_iam_role.codebuild_role.arn
        TemplatePath   = "build_output::sam-templated.yaml"

      }
    }
  }
}
