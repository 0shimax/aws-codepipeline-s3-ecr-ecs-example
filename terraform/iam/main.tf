module "code_build" {
  source = "./code_build"
  source_bucket_arn     = var.source_bucket_arn
  artifact_s3_buckt_arn = var.artifact_s3_buckt_arn
}

module "code_pipeline" {
  source                = "./code_pipeline"
  source_bucket_arn     = var.source_bucket_arn
  artifact_s3_buckt_arn = var.artifact_s3_buckt_arn
}