# provider用
provider_region = "<REGION>"

# VPC用
vpc_name         = "<VPC_NAME>"
vpc_cidr         = "10.0.0.0/16" # 一例。変更可能
azs              = ["<REGION>a","<REGION>c"] # EKSの使用で2AZは必須。a,cでなくても良い
private_subnets  = ["10.0.0.0/24", "10.0.1.0/24"]# 一例。変更可能
public_subnets   = ["10.0.2.0/24", "10.0.3.0/24"]# 一例。変更可能

# EKS用
cluster_name                        = "tf-eks-cluster" # 一例。変更可能
eks_managed_node_group_name         = "tf-eks-managed-ng" # 一例。変更可能

# k8s用
k8s_version = "1.31"

# ECR用
repository_name = "eks-app-repo"# 一例。変更可能