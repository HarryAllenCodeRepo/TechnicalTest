# Terraform Technical Task 

This guide outlines the steps to deploy AWS infrastructure using Terraform and automate the process with GitHub Actions. The infrastructure includes a VPC, subnets, an EC2 instance running Nginx, and associated security groups.

## Repository Information

- **Repository URL:** [https://github.com/HarryAllenCodeRepo/TechnicalTest](https://github.com/HarryAllenCodeRepo/TechnicalTest)

## Prerequisites

Before starting the deployment process, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS credentials with appropriate permissions. You can then add these credentials in the GitHub repository's secrets.

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

Configure AWS with the same.

### 3. Update Terraform Variables
Open main.tf and update the following variables when appropriate (file sent with the needed updates):

- ami_id: Set to "ami-08c149f9b2ace933d" (Amazon Linux 2 AMI).

- key_pair_name: Set to "my_key_pair_tech".

- region: Set to "eu-west-1".

### 4. Initialize Terraform
Run the following commands to initialize Terraform:

```bash
terraform init
```

### 5. Plan Terraform Changes

```bash
terraform plan
```

### 6. Deploy Infrastructure

```bash
terraform apply -auto-approve
```

### 7. Configure GitHub Actions Workflow
Open .github/workflows/terraform_deploy.yml and make sure the workflow configuration is correct. Ensure the correct branch triggers the workflow.

### 8. Manually Trigger GitHub Actions Workflow
If you want to explicitly trigger a workflow manually, you can create a dummy commit to the branch associated with the workflow, instead of having to make a change to any files. 
Ensure you have navigated to the directory where the Terraform configuration files ( (main.tf, etc.) and Github Actions workflow files (terraform_deploy.yml) are located.
Here's how you can do it:

```bash
cd /path/to/your/repository
```
```bash
git commit --allow-empty -m "Trigger GitHub Actions workflow"
git push origin master
```

### 9. Review GitHub Actions Deployment
Visit the "Actions" tab in your GitHub repository to monitor the progress of the deployment. This workflow will trigger on each push to the specified branch.

### 10. Cleanup (Optional)
If needed, you can destroy the deployed infrastructure using the following command:

```bash
terraform destroy -auto-approve
```
## Conclusion
This guide provides a step-by-step walkthrough for deploying AWS infrastructure using Terraform and automating the process with GitHub Actions. Ensure all steps are followed carefully, and refer to the GitHub Actions workflow for detailed logs and notifications in case of issues.

