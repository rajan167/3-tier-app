# Getting the DNS of load balancer
output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.external-alb.dns_name
}
output "dbpassword"{
    value = aws_db_instance.default.password
}