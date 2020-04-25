output "public_ip" {
  value       = aws_instance.amazon_linux.public_ip
  description = "Public IP of the web server"
}