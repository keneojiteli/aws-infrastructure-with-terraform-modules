terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-bucket-101325" #bucket name
    key            = "terraform.tfstate" # path to state file within the bucket
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true # native to s3, can replace dynamodb for state locking
}
}

provider "aws" {
  region = var.region
}


