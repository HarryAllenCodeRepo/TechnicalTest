# Infrastructure Configuration

# Variables
variable "ami_id" {
  default = "ami-08c149f9b2ace933d"
}

variable "key_pair_name" {
  default = "my_key_pair_tech"
}

# Define the AWS provider and set the region
provider "aws" {
  region = "eu-west-1"
}

# VPC and Subnets

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  
  # Tags for better organization
  tags = {
    Name        = "MyVPC"
    Environment = "Production"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-1b"
}

# EC2 Instances

# Web Server Instance
resource "aws_instance" "web_server_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  subnet_id = aws_subnet.public_subnet_1.id

  # Security Group Rules
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]
}

# Nginx Server Instance
resource "aws_instance" "nginx_server_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_pair_name

  subnet_id = aws_subnet.private_subnet_1.id

  # Security Group Rules
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1.12 -y
              sudo service nginx start
              sudo chkconfig nginx on
            EOF
}

# Security Groups

# Web Server Security Group
resource "aws_security_group" "web_server_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  # Security Group Rules
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
