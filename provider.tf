terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "s3-state-teraform-fbybybbyfds"
    key    = "aws-ecs-retail-store"
    region = "eu-west-1"
  }
}
