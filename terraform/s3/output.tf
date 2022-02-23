output "model_bucket_name" {
    value = data.aws_s3_bucket.infection.id
}

output "artifact_bucket_name" {
    value = aws_s3_bucket.code_pipeline_artifact.bucket
}

output "model_bucket_arn" {
    value = data.aws_s3_bucket.infection.arn
}

output "artifact_bucket_arn" {
    value = aws_s3_bucket.code_pipeline_artifact.arn
}