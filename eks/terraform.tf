# Дочірній модуль: лише вимоги до провайдера.
# provider "aws" конфігурується в кореневому модулі й успадковується сюди.
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 6.0"
    }
  }
}
