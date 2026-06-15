variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

# ---------- VPC ----------
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "mlops-eks-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b"]
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# ---------- EKS ----------
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "mlops-eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.31"
}

variable "cpu_instance_type" {
  description = "Instance type for CPU node group (Free Tier)"
  type        = string
  default     = "t3.micro"
}

variable "gpu_instance_type" {
  description = "Instance type for GPU-labelled node group (Free Tier placeholder)"
  type        = string
  default     = "t3.micro"
}

# ---------- Common ----------
variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    Project   = "mlops-course"
    ManagedBy = "terraform"
    Lesson    = "5-6"
  }
}
