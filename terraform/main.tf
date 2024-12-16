
provider "aws" {
  region = var.provider_region
}



module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~>5.16.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  
  enable_vpn_gateway = false

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


module "eks" {
    source = "./modules/eks"

    vpc_id                              = module.vpc.vpc_id
    private_subnets                     = module.vpc.private_subnets
    cluster_name                        = var.cluster_name
    k8s_version                         = var.k8s_version
}

module "ecr"{
  source = "./modules/ecr"

  repository_name = var.repository_name
}