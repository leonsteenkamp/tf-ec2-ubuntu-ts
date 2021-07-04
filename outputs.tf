# outputs.tf

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "domain-name" {
  value = aws_instance.app_server.public_dns
}

output "instance_ami" {
  value = data.aws_ami.ubuntu.id
}

output "ssh_command" {
  value = "ssh ${var.ssh_user}@${aws_instance.app_server.public_ip}"
}
