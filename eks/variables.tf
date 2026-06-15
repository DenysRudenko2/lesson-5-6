variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "mlops-eks"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster is deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for the EKS nodes (private subnets)"
  type        = list(string)
}

variable "cpu_instance_type" {
  description = "Instance type for the CPU node group (Free Tier)"
  type        = string
  default     = "t3.micro"
}

variable "gpu_instance_type" {
  description = "Instance type for the GPU-labelled node group (Free Tier placeholder)"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default     = {}
}
