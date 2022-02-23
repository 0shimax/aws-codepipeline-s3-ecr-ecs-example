resource "aws_codebuild_project" "xxxxx_project" {
  name         = local.codebuild_project_name
  description  = local.codebuild_project_definition
  service_role = var.codebuild_iam_role_arn

  artifacts {
    type      = "CODEPIPELINE"
    packaging = "ZIP"
  }
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_CUSTOM_CACHE"]
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = local.codebuild_image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_default_region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }
    environment_variable {
      name  = "MODEL_PATH"
      value = local.model_path
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }

    environment_variable {
      name  = "IMAGE_NAME"
      value = local.image_name
    }

    environment_variable {
      name  = "INFECTION_CONTAINER_NAME"
      value = var.infection_container_name
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
    environment_variable {
      name  = "IMAGE_CONF_FILE_NAME"
      value = local.image_conf_file_name
    }
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = var.log_group_name
    }
    s3_logs {
      status = "DISABLED"
    }
  }

  source {
    # https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectSource.html
    type      = local.source_type
    buildspec = local.build_spec_file_name
  }
}
