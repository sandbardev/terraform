##############################
# EKS cluster                #
##############################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name    = "main-eks-cluster"
  cluster_version = "1.33"

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access_cidrs     = ["179.218.21.185/32"] # my IP
  vpc_id                                   = module.vpc.vpc_id
  subnet_ids                               = module.vpc.private_subnets


  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 1
    }
  }
}

# setup kubectl
# aws eks update-kubeconfig --name YOUR_CLUSTER_NAME --region YOUR_AWS_REGION
