terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }

    backend "s3" {
      bucket = "nanda-remote-state-dev"
      key    = "terraform_aws_acm"
      region = "us-east-1"
      #dynamodb_table = "nanda-remote-state"
      encrypt = true
      use_lockfile = true
  }
}

provider "aws" {
  # Configuration options
}