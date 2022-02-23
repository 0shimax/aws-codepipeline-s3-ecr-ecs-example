module "xxxxx" {
  source = "./xxxxx"
  subnet_id                 = var.subnet_id
  security_group_name       = var.security_group_name
  grpc_sg_name              = var.grpc_sg_name
  codepipeline_iam_role_arn = var.codepipeline_iam_role_arn_xxxxx
  codebuild_project_name    = var.codebuild_project_name_xxxxx
  source_bucket             = var.source_bucket
  artifact_s3_buckt         = var.artifact_s3_buckt
  ecs_cluster_arn           = var.ecs_cluster_arn_xxxxx
  ecs_service_arn           = var.ecs_service_arn_xxxxx
  image_conf_file_name      = var.image_conf_file_name_xxxxx
}