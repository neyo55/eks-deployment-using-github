output "cluster_name" {
  value = aws_eks_cluster.myapp.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.myapp.endpoint
}

output "cluster_ca_certificate" {
  value = aws_eks_cluster.myapp.certificate_authority.0.data
}



