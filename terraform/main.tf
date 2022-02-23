terraform {
  required_version = ">= 1.1.3"
  backend "s3" {
    region  = "xxxxxxxx"
    bucket  = "xxxxxxxx"
    key     = "development/terraform.tfstate"
    profile = "xxxxxxxx"
  }
}

provider "aws" {
  region  = var.AWS_DEFAULT_REGION
  profile = var.AWS_PROFILE
}

module "s3" {
  source     = "./modules/s3"
  account_id = var.account_id
}

module "ecr" {
  source = "./modules/ecr"
}

# module "sg" {
#   source    = "./modules/security_group"
# }

# module "log_group" {
#   source = "./modules/log_group"
# }

module "iam" {
  source                = "./modules/iam"
  target_bucket_name    = module.s3.model_bucket_name
  region                = var.AWS_DEFAULT_REGION
  account_id            = var.account_id
  appmesh_name          = module.appmesh.appmesh_name
  source_bucket_arn     = module.s3.model_bucket_arn
  artifact_s3_buckt_arn = module.s3.artifact_bucket_arn
}

# module "ecs" {
#   source                                            = "./modules/ecs"
# }

module "code_build" {
  source                         = "./modules/code_build"
  codebuild_iam_role_arn         = module.iam.code_build_iam_role_arn
  aws_default_region             = var.AWS_DEFAULT_REGION
  aws_account_id                 = var.account_id
  infection_container_name_xxxxx = module.ecs.container_name_xxxxx
  image_repo_name_xxxxx          = module.ecr.image_repo_name_xxxxx
  log_group_name                 = module.log_group.codebuild_log_group
}

module "code_pipeline" {
  source                          = "./modules/code_pipeline"
  subnet_id                       = var.subnet_id
  security_group_name             = var.security_group_name
  grpc_sg_name                    = module.sg.grpc_sg_name
  codepipeline_iam_role_arn_xxxxx = module.iam.code_pipeline_iam_role_arn
  codebuild_project_name_xxxxx    = module.code_build.codebuild_project_name_xxxxx
  source_bucket                   = module.s3.model_bucket_name
  artifact_s3_buckt               = module.s3.artifact_bucket_name
  ecs_cluster_arn_xxxxx           = module.ecs.ecs_cluster_arn_xxxxx
  ecs_service_arn_xxxxx           = module.ecs.ecs_service_name_xxxxx
  image_conf_file_name_xxxxx      = module.code_build.image_conf_file_name_xxxxx
}
