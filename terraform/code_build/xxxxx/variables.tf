variable "codebuild_iam_role_arn" {
  type = string
}

variable "aws_default_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "image_repo_name" {
  type = string
}

variable "infection_container_name" {
  type = string
}

variable "log_group_name" {
  type = string
}

locals {
  source_type                  = "CODEPIPELINE"
  codebuild_project_name       = "xxxxx-fargate-ecr"
  codebuild_project_definition = "build ecr for infection-xxxxx"
  codebuild_image              = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
  codebuild_source_path        = "infection/codepipeline_source/xxxxx"
  build_spec_file_name         = "codepipeline/buildspec.yml"
  image_name                   = "grcp-cpp"
  image_conf_file_name         = "imagedef.json"
  model_path                   = "/models/pipeline.onnx"
}
