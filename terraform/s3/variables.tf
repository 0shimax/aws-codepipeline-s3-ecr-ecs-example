variable "account_id" {
    type = string
}

locals {
    model_bucket_name = "xxxxxx-infection"
    codepipeline_artifact_bucket_name = "xxxxx-codepipeline-artifact"
}