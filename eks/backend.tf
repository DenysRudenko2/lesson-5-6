# Backend для запуску цього модуля ОКРЕМО (standalone).
# Коли eks/ викликається з кореня як `module "eks" { source = "./eks" }`,
# backend береться з кореневого backend.tf, а цей блок ігнорується.
# Розкоментуйте, якщо застосовуєте лише папку eks/ окремо (тоді VPC треба
# під'єднати через data.terraform_remote_state до vpc-стейту).

# terraform {
#   backend "s3" {
#     bucket       = "mlops-tfstate-rudenko-152128592418"
#     key          = "lesson-5-6/eks/terraform.tfstate"
#     region       = "eu-north-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
