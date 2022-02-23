module "xxxxx" {
  source                   = "./xxxxx"
  codebuild_iam_role_arn   = var.codebuild_iam_role_arn
  aws_default_region       = var.aws_default_region
  aws_account_id           = var.aws_account_id
  image_repo_name          = var.image_repo_name_xxxxx
  infection_container_name = var.infection_container_name_xxxxx
  log_group_name           = var.log_group_name
}
