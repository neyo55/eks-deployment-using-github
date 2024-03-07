# This file is used to create an EKS cluster using the terraform-aws-modules/eks/aws module
module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"
    cluster_name = "myapp-eks-cluster"
    cluster_version = "1.29"

    cluster_endpoint_public_access  = true

    vpc_id = module.neyo-vpc.vpc_id
    subnet_ids = module.neyo-vpc.private_subnets

    tags = {
        environment = "development"
        application = "myapp"
    }

    # EKS managed node groups
    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 5
            desired_size = 3

            instance_types = ["t2.medium"]
        }
    }
}