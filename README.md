# Lesson 5-6 — VPC + EKS через офіційні Terraform-модулі

Модульний Terraform-проєкт, що піднімає в AWS повноцінну мережу (VPC) і керований
Kubernetes-кластер (EKS) з двома node group-ами — базовий каркас під ML-сервіси.

## Що створюється

- **VPC** через офіційний модуль [`terraform-aws-modules/vpc/aws`](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws):
  CIDR `10.0.0.0/16`, по 2 публічні та приватні сабнети у 2 AZ, Internet Gateway,
  один NAT Gateway, теги для авто-визначення сабнетів EKS-ом.
- **EKS** через офіційний модуль [`terraform-aws-modules/eks/aws`](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws) (v20):
  кластер `mlops-eks` з **двома managed node group-ами** — `cpu` і `gpu`
  (обидві на `t3.micro`, Free Tier). Доступ через kubectl одразу після `apply`
  (EKS Access Entries, `enable_cluster_creator_admin_permissions = true`).

## Структура

```
lesson-5-6/
├── main.tf          # викликає module "vpc" і module "eks"
├── variables.tf     # всі вхідні параметри з дефолтами
├── outputs.tf       # vpc_id, cluster_endpoint, команда для kubectl…
├── terraform.tf     # required_providers + provider "aws"
├── backend.tf       # S3 backend для стейту
├── vpc/             # дочірній модуль: обгортка над terraform-aws-modules/vpc/aws
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tf
│   └── backend.tf
├── eks/             # дочірній модуль: обгортка над terraform-aws-modules/eks/aws
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tf
│   └── backend.tf
└── README.md
```

Кореневий `main.tf` передає `vpc_id` та `private_subnets` з модуля `vpc` у модуль
`eks` — тобто композиція модулів (один спільний стейт, один `terraform apply`).

## Передумови

- Terraform >= 1.5, AWS CLI v2, `kubectl`
- Налаштований доступ до AWS (`aws configure`, профіль `default`)
- Існуючий S3-бакет для стейту (вказаний у `backend.tf`).
  Якщо запускаєте у власному акаунті — **змініть `bucket`** на свій унікальний.

## Як запустити

```bash
terraform init
terraform plan
terraform apply        # ~15–20 хв (створення EKS — найдовше)
```

Після `apply` підключіть kubectl (команда також є в `terraform output configure_kubectl`):

```bash
aws eks --region eu-north-1 update-kubeconfig --name mlops-eks
kubectl get nodes
```

Маєте побачити вузли з обох node group-ів (label `workload=cpu` і `workload=gpu`):

```bash
kubectl get nodes --show-labels | grep workload
```

## ⚠️ Вартість і прибирання

EKS control plane (~$0.10/год) + NAT Gateway (~$0.05/год) + EC2-ноди працюють
постійно. **Після перевірки обов'язково видаліть ресурси:**

```bash
terraform destroy
```

> S3-бакет зі стейтом можна лишити — він майже безкоштовний і потрібен для backend.

## Налаштування

Усі параметри — у `variables.tf` (регіон, CIDR, AZ, версія кластера, типи інстансів).
Перевизначаються через `-var` або `terraform.tfvars`.
