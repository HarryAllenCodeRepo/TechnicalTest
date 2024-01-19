# Specify the provider and region
provider "aws" {
  region = "eu-west-1"  # Set the AWS region to EU-West-1
}

# Task 1: Create a VPC and Subnets
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"  # Define the address range for the VPC
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"  # Define the address range for the first public subnet
  availability_zone       = "eu-west-1a"  # Specify the availability zone for the subnet
  map_public_ip_on_launch = true  # Enable automatic assignment of public IPs to instances in this subnet
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"  # Define the address range for the second public subnet
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id      = aws_vpc.my_vpc.id
  cidr_block  = "10.0.3.0/24"  # Define the address range for the first private subnet
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id      = aws_vpc.my_vpc.id
  cidr_block  = "10.0.4.0/24"  # Define the address range for the second private subnet
  availability_zone = "eu-west-1b"
}

# Task 2: Create an EC2 Instance
resource "aws_instance" "web_server_instance" {
  ami           = "ami-08c149f9b2ace933d"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "my_key_pair_tech"  # Specify the key pair for SSH access

  subnet_id = aws_subnet.public_subnet_1.id  # Place the instance in the first public subnet

  # Task 4: Security Group Rules
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]  # Associate with the web server security group
}

# Task 3: Configure Nginx using User Data script
resource "aws_security_group" "web_server_security_group" {
  vpc_id = aws_vpc.my_vpc.id

  # Task 4: Security Group Rules
  ingress {
    from_port = 22  # Allow SSH traffic
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP
  }

  ingress {
    from_port = 80  # Allow HTTP traffic
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
  }
}

# Task 3: Configure Nginx using User Data script
resource "aws_instance" "nginx_server_instance" {
  ami           = "ami-08c149f9b2ace933d"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = "my_key_pair_tech"  # Specify the key pair for SSH access

  subnet_id = aws_subnet.public_subnet_1.id  # Place the instance in the first public subnet

  # Task 4: Security Group Rules
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]  # Associate with the web server security group

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y  # Update the package repository
              sudo amazon-linux-extras install nginx1.12 -y  # Install Nginx
              sudo service nginx start  # Start the Nginx service
              sudo chkconfig nginx on  # Enable Nginx to start on boot
              EOF
}
