output "subnets" {
  description = "Subnets"
  value       = try(aws_subnet.create_subnets, [])
}
