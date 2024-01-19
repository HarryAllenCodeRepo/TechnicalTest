Terraform Technical Task
This guide walks you through deploying an AWS infrastructure using Terraform, including a Virtual Private Cloud (VPC), subnets, an EC2 instance with Nginx, and associated security group configurations. The deployment is automated using GitHub Actions.

Prerequisites
Before starting, make sure you have the following:

Terraform: Install Terraform locally by following the instructions here.
AWS Access Credentials: Obtain the AWS Access Key ID and Secret Access Key.

Getting Started
Step 1: Clone the Repository
git clone https://github.com/HarryAllenCodeRepo/TechnicalTest.git
cd TechnicalTest

Step 2: Update Variables
Open the main.tf file and update the following variables in the variable block:
  ami_id: Set to "ami-08c149f9b2ace933d" (Amazon Linux 2 AMI).
  key_pair_name: Set to "my_key_pair_tech".

Step 3: GitHub Secrets
Add the following GitHub Secrets to the repository:
  AWS_ACCESS_KEY_ID: the AWS Access Key ID.
  AWS_SECRET_ACCESS_KEY: the AWS Secret Access Key.

Step 4: Local Terraform Setup
Run the following commands to initialize and apply the Terraform configuration:
terraform init
This command initializes the working directory, downloads the necessary providers, and sets up the Terraform environment.

terraform plan
Review the plan to ensure it aligns with your expectations.

terraform apply -auto-approve
This command applies the changes and deploys the infrastructure. Be cautious, as this will create AWS resources.

Step 5: GitHub Actions Workflow
The GitHub Actions workflow is defined in the .github/workflows/terraform_deploy.yml file. This workflow is triggered on pushes to the master branch. It consists of the following steps:
  Checkout Repository: Checks out the repository to access its content.
  Set up Terraform: Uses the hashicorp/setup-terraform action to set up Terraform with the specified version.
  Configure AWS Credentials: Creates the AWS credentials file using GitHub Secrets.
  Terraform Init: Initializes Terraform in the GitHub Actions environment.
  Terraform Plan: Executes Terraform plan to check changes before applying.
  Terraform Apply: Applies Terraform changes. The -auto-approve flag skips the interactive approval prompt.
  Notify on Failure: If the pipeline fails, it notifies about the failure.

Step 6: Monitor Deployment
Navigate to the "Actions" tab in the GitHub repository (https://github.com/HarryAllenCodeRepo/TechnicalTest/actions) to monitor the progress of the deployment. The pipeline includes steps for Terraform initialization, planning, and applying.

Step 7: Verify Deployment
After the pipeline completes successfully, log in to the AWS Management Console and verify the creation of the VPC, subnets, and EC2 instance.

Troubleshooting
If the deployment fails, check the GitHub Actions logs for error messages. Additionally, review the Terraform scripts for any misconfigurations/typos.

For further assistance, refer to the Terraform documentation and GitHub Actions documentation.
