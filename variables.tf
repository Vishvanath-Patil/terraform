variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.20"
}

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "enable_irsa" {
  type = bool
}

variable "fargate_profiles" {
  type = map(any)
}

variable "cluster_enabled_log_types" {
  type = list(string)
}

variable "node_groups_defaults" {
  type = any
}

variable "node_groups" {
  type = map(any)
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}
