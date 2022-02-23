souce files -> S3 -> codebuild -> ecr -> ecs update

Note that you need to add `packaging = "ZIP"` to the artifacts settings because CodeBuild does not automatically unpack zip files.

If you don't create CodeBuild in VPC, it may be trapped by the pull limit of Docker image because it shares IP with other AWS users. To avoid this problem, use the AWS publec ECR Image.

Please add any other settings not listed here, such as ECS.