data "aws_s3_bucket" "infection" {
  bucket = local.model_bucket_name
}

resource "aws_s3_bucket" "code_pipeline_artifact" {
  bucket = local.codepipeline_artifact_bucket_name
}
