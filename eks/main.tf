# EKS-кластер через офіційний модуль terraform-aws-modules/eks/aws (v20).
# v20 дає доступ через EKS Access Entries — kubectl працює одразу після apply
# без kubernetes-провайдера й aws-auth ConfigMap.
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Публічний endpoint, щоб kubectl з локальної машини мав доступ
  cluster_endpoint_public_access = true

  # Дає IAM-користувачу, що створює кластер, права cluster-admin (через Access Entry)
  enable_cluster_creator_admin_permissions = true

  # Мережа з модуля vpc/ (передається з кореня)
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_group_defaults = {
    ami_type = "AL2023_x86_64_STANDARD"
  }

  # Дві node group-и: під CPU- та GPU-задачі.
  # Instance type — t3.micro (Free Tier) для обох, бо реальні GPU-інстанси
  # (g4dn/p-series) не входять у Free Tier. У проді gpu-група отримала б
  # instance_types = ["g4dn.xlarge"] + GPU AMI + taint nvidia.com/gpu.
  eks_managed_node_groups = {
    cpu = {
      name           = "cpu-ng"
      instance_types = [var.cpu_instance_type]
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      labels = {
        workload = "cpu"
      }
    }

    gpu = {
      name           = "gpu-ng"
      instance_types = [var.gpu_instance_type]
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      labels = {
        workload = "gpu"
      }
    }
  }

  tags = var.tags
}
