variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  # Free tier eligible
}

variable "key_name" {
  description = "Name of the EC2 key pair (must already exist in AWS)"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access (your IP/0.0.0.0 for any)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "github_repo" {
  description = "GitHub repository URL"
  type        = string
  default     = "https://github.com/khanmehtab276/cloud-monitoring-dashboard.git"
}

variable "docker_image" {
  description = "Docker image to use"
  type        = string
  default     = "khanmehtab276/cloud-monitoring-dashboard:latest"
}
