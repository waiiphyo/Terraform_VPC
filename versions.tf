terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.1"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/home/frontiir/.aws/config"]
  shared_credentials_files = ["/home/frontiir/.aws/credentials"]
  profile                  = "waiphyo-dev-profile"
  alias                    = "dev"
  region                   = "us-east-1"
}

provider "aws" {
  shared_config_files      = ["/home/frontiir/.aws/config"]
  shared_credentials_files = ["/home/frontiir/.aws/credentials"]
  profile                  = "waiphyo-prod-profile"
  alias                    = "prod"
  region                   = "ap-southeast-1"
}