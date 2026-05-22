# Cloud Monitoring Dashboard 📊

A simple system monitoring application built with Python Flask, Docker, and deployed with Terraform on AWS.

## Features ✨

- 💻 **CPU Monitoring** - Real-time CPU usage and core count
- 💾 **Memory Tracking** - RAM usage and availability
- 💿 **Disk Space** - Storage usage monitoring
- 📱 **Beautiful Dashboard** - Modern web interface with live updates
- 🐳 **Docker** - Containerized application
- ☁️ **AWS Deployment** - Automated setup with Terraform

## Tech Stack

- **Backend**: Python 3.11, Flask
- **Frontend**: HTML5, CSS3, JavaScript
- **Containerization**: Docker
- **Infrastructure**: Terraform, AWS EC2
- **Monitoring**: psutil

## Project Structure

```
cloud-monitoring-dashboard/
├── app.py                    # Flask application
├── requirements.txt          # Python dependencies
├── Dockerfile                # Docker image definition
├── templates/
│   └── dashboard.html        # Web dashboard UI
├── terraform/
│   ├── main.tf              # AWS EC2 infrastructure
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Output values
│   ├── user_data.sh         # EC2 initialization script
│   └── terraform.tfvars.example # Example configuration
├── .gitignore
└── README.md
```

## Quick Start 🚀

### Prerequisites

- AWS Account (free tier eligible)
- Terraform installed (v1.0+)
- AWS CLI configured with credentials
- EC2 key pair created in your AWS region
- Git

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/khanmehtab276/cloud-monitoring-dashboard.git
   cd cloud-monitoring-dashboard
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the application**
   ```bash
   python app.py
   ```
   Dashboard: `http://localhost:5000`

### Build Docker Image

```bash
docker build -t monitoring-app:latest .
docker run -p 5000:5000 monitoring-app:latest
```

Access at: `http://localhost:5000`

## AWS Deployment with Terraform 🌍

### Step 1: Create EC2 Key Pair

1. Go to AWS EC2 Console
2. Navigate to **Key Pairs**
3. Click **Create key pair**
4. Name it (e.g., `monitoring-app`)
5. Download the `.pem` file
6. Save it safely: `chmod 400 monitoring-app.pem`

### Step 2: Configure Terraform

1. **Navigate to terraform directory**
   ```bash
   cd terraform
   ```

2. **Copy example configuration**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit terraform.tfvars**
   ```bash
   nano terraform.tfvars
   ```
   Update:
   - `key_name = "your-key-pair-name"` (the one you created above)
   - `aws_region = "us-east-1"` (your region)
   - `allowed_ssh_cidr = "your-ip/32"` (optional, for SSH access)

### Step 3: Deploy

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Plan deployment**
   ```bash
   terraform plan
   ```

3. **Apply (create infrastructure)**
   ```bash
   terraform apply
   ```
   Type `yes` when prompted

4. **Get outputs**
   ```bash
   terraform output
   ```
   You'll see:
   - `dashboard_url` - Access your app here!
   - `instance_public_ip` - EC2 instance IP
   - `ssh_command` - SSH into the instance

### Step 4: Access Dashboard

Open your browser and go to the `dashboard_url`:
```
http://<your-instance-ip>:5000
```

## API Endpoints 📡

### Health Check
```bash
GET /health
```
Response:
```json
{
  "status": "healthy",
  "timestamp": "2024-05-22T12:34:56"
}
```

### Get All Metrics
```bash
GET /api/metrics
```
Response:
```json
{
  "timestamp": "2024-05-22T12:34:56",
  "cpu": {
    "percent": 25.5,
    "count": 4
  },
  "memory": {
    "percent": 45.2,
    "used_gb": 2.31,
    "total_gb": 8.0
  },
  "disk": {
    "percent": 32.1,
    "used_gb": 20.5,
    "total_gb": 64.0
  }
}
```

## Terraform Commands 🛠️

### View current infrastructure
```bash
cd terraform
terraform show
```

### Destroy infrastructure (when done learning)
```bash
cd terraform
terraform destroy
```
Type `yes` when prompted. This will delete the EC2 instance and stop charges.

### Check infrastructure state
```bash
cd terraform
terraform state list
```

## Environment Variables 🔧

Can be customized in the Flask app:
- `PORT` - Server port (default: 5000)
- `FLASK_ENV` - Development/production (default: production)

## Troubleshooting 🐛

### Terraform can't find AWS credentials
```bash
# Configure AWS credentials
aws configure
```

### Dashboard shows "Connection refused"
- Wait 2-3 minutes for EC2 to boot and Docker to start
- Check instance is running: `terraform output instance_id`
- SSH into instance: `ssh -i key.pem ec2-user@<ip>`
- Check Docker: `docker ps`

### High memory usage on dashboard
- This is normal for a monitoring app
- Can be optimized with caching later

### Port 5000 already in use (local)
```bash
# Kill process
lsof -i :5000
kill -9 <PID>
```

## Learning Outcomes 📚

By completing this project, you'll learn:

1. **Python & Flask**
   - Building REST APIs
   - Templating with Jinja2
   - Request/response handling

2. **System Administration**
   - Monitoring system resources
   - Understanding Linux metrics

3. **Docker**
   - Writing Dockerfiles
   - Building and running containers
   - Container networking

4. **Infrastructure as Code (IaC)**
   - Writing Terraform configurations
   - Automating infrastructure deployment
   - State management

5. **AWS**
   - EC2 instances
   - Security groups
   - Free tier usage

6. **Frontend Development**
   - HTML/CSS/JavaScript
   - Real-time data updates
   - Responsive design

## Next Steps 🎯

After mastering this, try:

1. **Add Ansible**
   - Replace user_data.sh with Ansible playbooks
   - Manage configurations declaratively

2. **Add Docker Hub**
   - Push Docker image to Docker Hub
   - Use in Terraform

3. **Add Database**
   - Store metrics in PostgreSQL/RDS
   - Add historical data tracking

4. **Add CI/CD**
   - GitHub Actions to auto-build Docker images
   - Auto-deploy on push

5. **Add Kubernetes**
   - Deploy to EKS instead of EC2
   - Auto-scaling
   - Load balancing

6. **Add Monitoring**
   - Prometheus metrics
   - Grafana dashboards

## Important Notes ⚠️

- **Free Tier**: t2.micro is free for 12 months
- **Costs**: Only pay if you exceed free tier limits
- **Stop Charges**: Always run `terraform destroy` when done learning
- **Security**: Don't commit `terraform.tfvars` with real values to public repos

## Support 💬

If you have questions:
- Check Terraform docs: https://registry.terraform.io/
- AWS documentation: https://docs.aws.amazon.com/
- Flask docs: https://flask.palletsprojects.com/

## Author ✍️

**Mehtab Khan**
- GitHub: [@khanmehtab276](https://github.com/khanmehtab276)
- Learning Path: Cloud Technologies

## License 📄

MIT License - Feel free to use for learning!

---

**Happy Learning! 🚀**

Start simple, learn the fundamentals, then add complexity as you grow!
