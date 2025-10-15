terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-bucket-101325" #bucket name
    key            = "tf-state" # path to state file within the bucket
    region         = "us-east-1"
    # dynamodb_table = "terraform-locks" # dynamodb table to enable lock feature
    encrypt        = true
    use_lockfile   = true # native to s3, can replace dynamodb for state locking
}
}

provider "aws" {
  region = var.region
  # shared_credentials_files = ["~/.aws/credentials"] 
  # profile = "default"
}


