# Description: This file is used to create a VPC in AWS.
# The script will create an Amazon Virtual Private Cloud (VPC) using the terraform-aws-modules/vpc/aws module.
# The VPC will have public and private subnets, and NAT gateways will be created in the public subnets.
# The VPC will be tagged with the kubernetes.io/cluster/myapp-eks-cluster tag,
# and the public and private subnets will be tagged with the kubernetes.io/cluster/myapp-eks-cluster and kubernetes.io/role/elb tags, respectively.
data "aws_availability_zones" "azs" {}
module "neyo-vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.5.2"
  name            = "neyo-vpc"
  cidr            = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets  = var.public_subnet_cidr_blocks
  azs             = data.aws_availability_zones.azs.names

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                  = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"         = 1
  }
}