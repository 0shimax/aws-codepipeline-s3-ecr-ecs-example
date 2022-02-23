output "codebuild_project_name" {
    value = aws_codebuild_project.xxxxx_project.name
}

output "image_conf_file_name" {
    value = local.image_conf_file_name
}