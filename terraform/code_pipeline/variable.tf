variable "subnet_id" {
    type = string
}

variable "security_group_name" {
    type = string
}

variable "grpc_sg_name" {
    type = string
}

variable "codepipeline_iam_role_arn_xxxxx" {
    type=string
}

variable "codebuild_project_name_xxxxx" {
    type=string
}

variable "source_bucket" {
    type=string
}

variable "artifact_s3_buckt" {
    type=string
}

variable "ecs_cluster_arn_xxxxx" {
    type=string
}

variable "ecs_service_arn_xxxxx" {
    type=string
}

variable "image_conf_file_name_xxxxx" {
    type=string
}