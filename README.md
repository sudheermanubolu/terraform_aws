# mymovies Terraform Deployment to AWS

Terraform code to deploy a frontend application on aws. The code deploys below.

- VPC
- 6 subnets (3 public and 3 private)
- Internet Gateway
- NAT Gateway
- Routes and Assign them to subnets
- Security Groups for ELB, EFS, MySQL and ASG
- MySQL
- Elastic LoadBalancer (ELB)
- Route53
- Elastic FileSystem (EFS)
- Auto Scaling Group (ASG)
- IAM Account for Profbob

## Installation

```
terraform plan
terraform apply
```

For more details on Terraform check docs at [DOCS](https://www.terraform.io/docs/providers/aws/)
