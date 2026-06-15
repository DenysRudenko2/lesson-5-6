# Backend для запуску цього модуля ОКРЕМО (standalone).
# Коли vpc/ викликається з кореня як `module "vpc" { source = "./vpc" }`,
# backend береться з кореневого backend.tf, а цей блок ігнорується.
# Розкоментуйте, якщо застосовуєте лише папку vpc/ окремо.

# terraform {
#   backend "s3" {
#     bucket       = "mlops-tfstate-rudenko-152128592418"
#     key          = "lesson-5-6/vpc/terraform.tfstate"
#     region       = "eu-north-1"
#     encrypt      = true
#     use_lockfile = true
#   }
# }
