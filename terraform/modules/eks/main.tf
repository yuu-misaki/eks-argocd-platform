
# autoモードのEKSクラスタを作成
module "eks_auto" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name                   = var.cluster_name
  cluster_version                = var.k8s_version
  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true


  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }
}

# ~/.kube/configの自動生成
resource "null_resource" "kubeconfig" {
  triggers = {
    cluster_name = var.cluster_name
  }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [module.eks_auto]
}


locals {
  # eksモジュールはIRSA有効時にcluster_oidc_issuer_urlを出力するため、これを用いてIAMロールの信頼条件に利用する
  oidc_issuer_url = replace(module.eks_auto.cluster_oidc_issuer_url, "https://", "")
}

# image updater用のIAMロール作成
resource "aws_iam_role" "argocd_image_updater_role" {
  name = "argocd-image-updater-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = module.eks_auto.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_issuer_url}:sub" = "system:serviceaccount:argocd:argocd-image-updater"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "argocd_image_updater_ecr_policy" {
  name = "argocd-image-updater-ecr-access"
  role = aws_iam_role.argocd_image_updater_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
        "ecr:GetAuthorizationToken",
        "ecr:ListImages",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
        Resource = "*"
      }
    ]
  })
}

