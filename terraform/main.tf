provider "aws" {
  region = var.aws_region
}

# Security Group
resource "aws_security_group" "monitoring_app" {
  name_prefix = "monitoring-app-"
  description = "Security group for monitoring dashboard"

  # Allow HTTP (port 80)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS (port 443)
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (port 22) - for debugging only
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # Allow application port (5000)
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "monitoring-app-sg"
  }
}

# EC2 Instance
resource "aws_instance" "monitoring_app" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.monitoring_app.id]
  
  # Associate public IP
  associate_public_ip_address = true

  # User data script to install Docker and run the app
  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    github_repo = var.github_repo
    docker_image = var.docker_image
  }))

  tags = {
    Name = "monitoring-dashboard"
  }

  depends_on = [aws_security_group.monitoring_app]
}

# Get latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
