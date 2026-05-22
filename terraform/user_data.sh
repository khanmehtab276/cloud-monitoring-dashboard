#!/bin/bash
set -e

# Update system
yum update -y

# Install Docker
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Clone repository
cd /home/ec2-user
git clone ${github_repo} monitoring-app
cd monitoring-app

# Build Docker image
docker build -t monitoring-app:latest .

# Run Docker container
docker run -d \
  --name monitoring-dashboard \
  --restart unless-stopped \
  -p 5000:5000 \
  monitoring-app:latest

echo "✅ Deployment complete!"
docker ps
