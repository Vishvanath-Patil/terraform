cluster_name    = "eks-cluster"
cluster_version = "1.25"
subnets         = ["subnet-*******", "subnet-*******","subnet-******","subnet-******"]
vpc_id          = "vpc-********"
enable_irsa     = true
fargate_profiles = {
  system-stateless = {
    name = "default"
    subnets = ["subnet-0b9c3bef3238188b4", "subnet-0ae8cd00b63e6df3e"]
    selectors = [
      {
        namespace = "kube-system"
        labels = {
          k8s-app = "kube-dns"
        }
      },
      {
        namespace = "default"
      }
    ]
  },
  poc = {
    name = "fargate"
    subnets = ["subnet-******", "subnet-*******"]
    selectors = [
      {
        namespace = "poc"
        labels = {
          infrastructure = "fargate"
        }
      },
      {
        namespace = "default"
      }
    ]
  }
}
cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
node_groups_defaults = {
  ami_type  = "AL2_x86_64"
  disk_size = 50
}
node_groups = {
  stateful = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1

    subnets  = ["subnet-*******", "subnet-**********"]

    instance_types = ["t3.large"]
    capacity_type  = "ON_DEMAND"
  }
}
map_roles = []
map_users = [
  {
    userarn  = "arn:aws:iam::123456789:user/selvam"
    username = "selvam"
    groups   = ["system:masters"]
  }
]
