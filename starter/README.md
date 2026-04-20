# Udagram - Deploy Infrastructure as Code

## Project Overview

This project deploys a highly available web application called **Udagram** to AWS using **Infrastructure as Code (IaC)** with CloudFormation.

The infrastructure is split into two independent stacks:

- **Network Stack** → provisions VPC, subnets, routing, and gateways
- **Application Stack** → provisions EC2 instances, Load Balancer, S3 bucket, and IAM roles

The application serves static content hosted in an S3 bucket and delivered through EC2 instances behind an Application Load Balancer.

---

## Architecture Summary

The solution follows AWS best practices for high availability:

- VPC with CIDR block `10.0.0.0/16`
- 2 Public Subnets (for Load Balancer & NAT Gateways)
- 2 Private Subnets (for EC2 instances)
- Internet Gateway for public access
- NAT Gateways for private subnet internet access
- Auto Scaling Group with 4 EC2 instances (Ubuntu 22, t2.micro)
- Application Load Balancer (ALB) for traffic distribution
- S3 bucket for static content
- IAM Role allowing EC2 instances to access S3

Traffic Flow:

User → ALB → EC2 Instances → S3 (static content)

---

## Files

```text
starter/
├── network.yml
├── network-parameters.json
├── udagram.yml
├── udagram-parameters.json
├── create.sh
├── update.sh
├── delete.sh
└── README.md

```


---

## Prerequisites

- AWS CLI installed and configured
- Active AWS credentials (Udacity lab)
- Bash terminal
- Permissions to create:
  - CloudFormation stacks
  - EC2 instances
  - IAM roles
  - S3 buckets
  - VPC resources

---

## Create the Infrastructure

### Navigate to the project directory:

```bash
cd starter
```

### Make scripts executable:

``` bash
chmod +x create.sh update.sh delete.sh
```
### Run the create script:
```bash
./create.sh
```
>> This will:
>> Create the network stack
>> Wait for completion
>> Create the application stack

### Update the infrastructure
``` bash
./update.sh
```
### Delete the infrastructure 

``` bash
./delete.sh
```

## Working Application URL

```
http://udagram-alb-1221310502.us-east-1.elb.amazonaws.com
```
### Response
```
It works! Udagram, Udacity
```
---

## Challenges Faced

- Resolved S3 bucket ACL issue by switching to bucket policies
- Fixed IAM permission issue by using instance profile Name instead of ARN
- Corrected Ubuntu AMI retrieval by using the proper SSM parameter path

