# Віддалений стейт у S3-бакеті (створений у Темі 4).
# ⚠️ Якщо застосовуєте проєкт у власному акаунті — змініть bucket на свій
# (ім'я S3-бакета має бути глобально унікальним).
terraform {
  backend "s3" {
    bucket       = "mlops-tfstate-rudenko-152128592418"
    key          = "lesson-5-6/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
