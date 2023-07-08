terraform {
  backend "s3" {
    bucket = "rosie-jo-cloud-resume-challenege-tfstate"
    region = "eu-west-2"
    key = "path"
}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region = "us-east-1"
}


resource "random_string" "random_suffix" {
  length  = 6
  special = false
  upper   = false
}






