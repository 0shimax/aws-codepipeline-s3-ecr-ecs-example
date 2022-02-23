data "aws_subnet" "development" {
  id = var.subnet_id
}

data "aws_security_groups" "internal" {
  filter {
    name   = "vpc-id"
    values = [data.aws_subnet.development.vpc_id]
  }
  filter {
    name   = "group-name"
    values = [var.security_group_name, var.grpc_sg_name, "https"]
  }
}

resource "aws_codepipeline" "xxxxx_pipeline" {
  name     = local.code_pipeline_name
  role_arn = var.codepipeline_iam_role_arn

  artifact_store {
    location = var.artifact_s3_buckt
    type     = "S3"
  }

  stage {
    # https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html#reference-action-artifacts
    name = "Source"

    # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-S3.html
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        S3Bucket             = var.source_bucket
        S3ObjectKey          = local.source_key
        PollForSourceChanges = "false"
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
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        # https://docs.aws.amazon.com/codepipeline/latest/userguide/pipelines-create.html        
        ClusterName = var.ecs_cluster_arn
        ServiceName = var.ecs_service_arn
        # https://docs.aws.amazon.com/codepipeline/latest/userguide/file-reference.html#pipelines-create-image-definitions
        FileName    = var.image_conf_file_name
      }
    }
  }
}