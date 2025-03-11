# Task

This task involves provisioning an EC2 server, installing an SQL server on it, and setting up a script to execute queries on the database. T

## Directory Structure

This repository contains infrastructure and scripts for managing MySQL databases using Terraform and shell scripts.

```
│── query-script/ 
│ ├── query_mysql.sh # Script to run MySQL queries 
│── terraform/ 
│ ├── install_mysql.sh # Shell script to install MySQL 
│ ├── main.tf # Terraform main configuration 
│ ├── providers.tf # Terraform provider configuration 
│ ├── terraform.tfvars # Terraform variables 
│ ├── variables.tf # Terraform variables definition
```

## Step-1: Spin up a Micro Instance in a choice of your cloud provider.

- The EC2 instance is provisioned using Infrastructure as Code (IaC) with Terraform. The required configuration files are stored in the terraform directory.

```
terraform/
│── main.tf                     # Defines EC2 instance and resources
│── providers.tf                 # Configures the cloud provider
│── variables.tf                 # Stores configurable parameters
│── terraform.tfvars             # Variable values for customization
│── install_mysql.sh             # User data script for MySQL setup
```

- The EC2 instance is created using Terraform. A user-data script (install_mysql.sh) is executed automatically on the instance. This script installs MySQL, updates the configuration, and ensures the service is running.

