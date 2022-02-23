data "template_file" "codebuild_service" {
  template = file("./modules/iam/code_build/codebuild_build_policy.json")

  vars = {
    source_bucket_arn     = var.source_bucket_arn
    artifact_s3_buckt_arn = var.artifact_s3_buckt_arn
  }
}


data "aws_iam_policy_document" "codebuild_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild_service" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.codebuild_service.json
}

resource "aws_iam_role_policy" "codebuild_service_role" {
  name   = "${local.role_name}Policy"
  role   = aws_iam_role.codebuild_service.name
  policy = data.template_file.codebuild_service.rendered
}
