# Valid8Me Terraform Technical Task 

This guide outlines the steps to deploy AWS infrastructure using Terraform and automate the process with GitHub Actions. The infrastructure includes a VPC, subnets, an EC2 instance running Nginx, and associated security groups.

## Repository Information

- **Repository URL:** [https://github.com/HarryAllenCodeRepo/TechnicalTest](https://github.com/HarryAllenCodeRepo/TechnicalTest)

## Prerequisites

Before starting the deployment process, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS credentials with appropriate permissions. You can set up these credentials in the GitHub repository's secrets.

## Steps

### 1. Clone the Repository

```bash
git clone https://github.com/HarryAllenCodeRepo/TechnicalTest.git
cd TechnicalTest
```
### 2. Set AWS Credentials in GitHub Secrets
Go to your GitHub repository, navigate to "Settings" > "Secrets," and add the following secrets:

- AWS_ACCESS_KEY_ID: AWS Access Key ID

- AWS_SECRET_ACCESS_KEY: AWS Secret Access Key

### 3. Update Terraform Variables
Open main.tf and update the following variables:

- ami_id: Set to "ami-08c149f9b2ace933d" (Amazon Linux 2 AMI).

- key_pair_name: Set to "my_key_pair_tech".

- region: Set to "eu-west-1".

### 4. Configure GitHub Actions Workflow
Open .github/workflows/terraform_deploy.yml and make sure the workflow configuration is correct. Ensure the correct branch triggers the workflow.

### 5. Initialize Terraform
Run the following commands to initialize Terraform:

```bash
terraform init
```

### 6. Plan Terraform Changes

```bash
terraform plan
```

### 7. Deploy Infrastructure

```bash
terraform apply -auto-approve
```

### 8. Review GitHub Actions Deployment
Visit the "Actions" tab in your GitHub repository to monitor the progress of the deployment. This workflow will trigger on each push to the specified branch.

### 9. Cleanup (Optional)
If needed, you can destroy the deployed infrastructure using the following command:

```bash
terraform destroy -auto-approve
```
## Conclusion
This guide provides a step-by-step walkthrough for deploying AWS infrastructure using Terraform and automating the process with GitHub Actions. Ensure all steps are followed carefully, and refer to the GitHub Actions workflow for detailed logs and notifications in case of issues.

