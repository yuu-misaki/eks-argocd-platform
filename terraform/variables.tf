
# provider用環境変数
variable "provider_region" {
  default = "<REGION>" 
}

# VPC環境変数
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "azs" {}
variable "public_subnets" {}
variable "private_subnets" {}

## EKS環境変数
variable "cluster_name" {}
variable "eks_managed_node_group_name" {}

# kubernetes関連
variable "k8s_version" {
  default = "1.31"
}

# ECR用
variable "repository_name" {}