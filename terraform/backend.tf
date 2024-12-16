terraform {
  # terraformのバージョン条件
  required_version = "~> 1.9.8"

  # 実行するproviderの条件
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.79.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>2.14.0"
    }
  }
  backend "s3" {
    bucket         = "<BACKEND_S3_NAME>"
    key            = "eks-cluster/terraform.tfstate"
    region         = "<REGION>"
    encrypt        = true
  }
}
