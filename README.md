# TechnicalTest
Overview This project uses Terraform to deploy an AWS infrastructure that includes a Virtual Private Cloud (VPC) with public and private subnets, an EC2 instance running an Nginx web server, and necessary security groups. The deployment process is automated through a GitHub Actions pipeline for streamlined development.

Project Structure The project is organized into the following directories:

terraform: Contains Terraform configuration files. main.tf: Specifies the AWS provider, VPC, subnets, EC2 instance, and security groups. variables.tf: Declares input variables. outputs.tf: Defines output values. .github/workflows: GitHub Actions workflow configuration. terraform-deploy.yml: Automates the Terraform deployment process.

Prerequisites Ensure you have the following prerequisites before using this project:

Terraform installed. AWS credentials configured. AWS key pair for SSH access. Usage Clone the repository:

git clone https://github.com/ [insert later] Navigate to the terraform directory:

cd terraform Initialize Terraform:

terraform init Modify variables.tf if necessary.

Deploy the infrastructure:

terraform apply Follow the prompts to confirm the deployment.

Access the Nginx web server by navigating to the public IP address of the EC2 instance.

GitHub Actions The GitHub Actions pipeline is triggered on each push to the repository. It automates the Terraform deployment process and includes steps for initialization, planning, and applying changes. AWS credentials are securely handled using GitHub Secrets.

Cleanup To destroy the deployed infrastructure, run:

terraform destroy Follow the prompts to confirm the destruction.

Important Notes Ensure that AWS credentials are properly configured and have the necessary permissions. Keep sensitive information, such as AWS access keys and private key files, secure and never expose them in public repositories. Feel free to customize this README according to your project's specific details and requirements.
