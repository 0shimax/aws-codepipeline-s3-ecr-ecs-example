data "template_file" "codepipeline_service" {
  template = file("./modules/iam/code_pipeline/codepipeline_pipeline_policy.json")

  vars = {
    source_bucket_arn     = var.source_bucket_arn
    artifact_s3_buckt_arn = var.artifact_s3_buckt_arn
  }
}


data "aws_iam_policy_document" "codepipeline_service" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline_service" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.codepipeline_service.json
}

resource "aws_iam_role_policy" "codepipeline_service" {
  name   = "${local.role_name}Policy"
  role   = aws_iam_role.codepipeline_service.name
  policy = data.template_file.codepipeline_service.rendered
}
