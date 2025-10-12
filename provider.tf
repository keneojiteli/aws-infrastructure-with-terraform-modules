terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket" #bucket name
    key            = "tf-state" # path to state file within the bucket
    region         = var.region
    dynamodb_table = "terraform-locks" # dynamodb table to enable lock feature
    encrypt        = true
    use_lockfile   = true
}
}

provider "aws" {
  region = var.region
  shared_credentials_files = ["~/.aws/credentials"] 
  profile = "default"
}


