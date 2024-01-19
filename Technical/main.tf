# Infrastructure Configuration

# Variables for reusability and easy updates
variable "ami_id" {
  default = "ami-08c149f9b2ace933d"  # Amazon Linux 2 AMI
}

variable "key_pair_name" {
  default = "my_key_pair_tech"
}

# Define the AWS provider and set the region
provider "aws" {
  region = "eu-west-1"
}

# Task 1: Create a VPC and Subnets

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Define the address range for the VPC
  
  # Tags for better organization
  tags = {
    Name        = "MyVPC"
    Environment = "Production"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"  # Define the address range for the first public subnet
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"  # Define the address range for the second public subnet
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"  # Define the address range for the first private subnet
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"  # Define the address range for the second private subnet
  availability_zone = "eu-west-1b"
}

# Task 2: Create an EC2 Instance

# Web Server Instance
resource "aws_instance" "web_server_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  subnet_id = aws_subnet.public_subnet_1.id  # Place the instance in the first public subnet

  # Task 4: Security Group Rules
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]  # Associate with the web server security group
}

# Task 3: Configure Nginx using User Data script

# Web Server Security Group
resource "aws_security_group" "web_server_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  # Task 4: Security Group Rules
  # Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Nginx Server Instance
resource "aws_instance" "nginx_server_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name  # Specify the key pair for SSH access

  subnet_id = aws_subnet.private_subnet_1.id  # Place the instance in the first private subnet

  # Task 4: Security Group Rule
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]  # Associate with the web server security group

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y  # Update the package repository
              sudo amazon-linux-extras install nginx1.12 -y  # Install Nginx
              sudo service nginx start  # Start the Nginx service
              sudo chkconfig nginx on  # Enable Nginx to start on boot
            EOF
}
