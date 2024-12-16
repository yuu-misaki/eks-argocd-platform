
# provider用環境変数
variable "provider_region" {
  default = "<REGION>" 
}

# VPC環境変数
variable "vpc_id" {}
variable "private_subnets" {}

## EKS環境変数
variable "cluster_name" {}

# k8s用
variable "k8s_version" {
  default = "1.31"
}