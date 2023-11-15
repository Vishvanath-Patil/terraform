data "aws_eks_cluster" "cluster" {
  name = module.eks-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

module "eks-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = var.subnets
  vpc_id          = var.vpc_id
  enable_irsa     = var.enable_irsa

  fargate_profiles = var.fargate_profiles

  cluster_enabled_log_types = var.cluster_enabled_log_types

  node_groups_defaults = var.node_groups_defaults

  node_groups = var.node_groups

  map_users = var.map_users
  map_roles = var.map_roles
}

module "eks-cluster-autoscaler" {
  source  = "lablabs/eks-cluster-autoscaler/aws"
  version = "1.3.0"

  cluster_identity_oidc_issuer     = module.eks-cluster.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = module.eks-cluster.oidc_provider_arn
  cluster_name                     = var.cluster_name
  helm_chart_version               = "9.9.2"

}



resource "helm_release" "alb-ingress-controller" {
  name = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts" 
  chart = "aws-load-balancer-controller"

  namespace = "kube-system"
  set {
    name = "clusterName"
    value = var.cluster_name
  }

  set {
    name = "serviceAccount.create"
    value = true
  }

  set {
    name = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb_ingress.arn
  }

}
