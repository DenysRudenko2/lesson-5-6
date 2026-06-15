# Кореневий модуль: оркеструє обидва дочірні модулі (vpc + eks).
# Один state, один `terraform apply`. EKS отримує мережу напряму з VPC-модуля.

module "vpc" {
  source = "./vpc"

  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  tags            = var.tags
}

module "eks" {
  source = "./eks"

  cluster_name      = var.cluster_name
  cluster_version   = var.cluster_version
  cpu_instance_type = var.cpu_instance_type
  gpu_instance_type = var.gpu_instance_type

  # Мережа з VPC-модуля: ноди — у приватних сабнетах
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = var.tags

  depends_on = [module.vpc]
}
