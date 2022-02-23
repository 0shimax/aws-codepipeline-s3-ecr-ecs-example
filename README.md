souce files -> S3 -> codebuild -> ecr -> ecs update

If you don't create codebuild in VPC, it may be trapped by the pull limit of Docker image because it shares IP with other AWS users. To avoid this problem, use the AWS publec ECR Image.