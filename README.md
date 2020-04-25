# mymovies Terraform Deployment to AWS

Terraform code to deploy a frontend application with MySQL DB on AWS. The code deploys below.

### Networking & Content Delivery

- VPC
- 6 subnets (3 public and 3 private)
- Internet Gateway
- NAT Gateway
- Routes and Assign them to subnets
- Route53

### Compute

- Security Groups for ELB, EFS, MySQL and ASG
- Auto Scaling Group (ASG)
- Elastic LoadBalancer (ELB)
- Key Pair

### Storage

- Elastic FileSystem (EFS)

### Database

- MySQL

### Security, Identity, & Compliance

- IAM Account for user login

### Monitoring

- Email budget alerts
- SNS topic for Mobile and Email Alerts
- CloudWatch for CPU and Alerting with SNS
-

## Installation

```
terraform plan
terraform apply
```

For more details on Terraform check docs at [DOCS](https://www.terraform.io/docs/providers/aws/)
