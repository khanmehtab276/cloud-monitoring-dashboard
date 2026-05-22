output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.monitoring_app.public_ip
}

output "instance_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.monitoring_app.public_dns
}

output "dashboard_url" {
  description = "URL to access the monitoring dashboard"
  value       = "http://${aws_instance.monitoring_app.public_ip}:5000"
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.monitoring_app.id
}

output "ssh_command" {
  description = "SSH command to connect to the instance"
  value       = "ssh -i your-key.pem ec2-user@${aws_instance.monitoring_app.public_ip}"
}
