output "default_vpc" {
  description = "The default VPC."
  value       = aws_default_vpc.default
}

output "default_security_group" {
  description = "The default security group."
  value       = aws_default_security_group.default
}

output "default_network_acl" {
  description = "The default network ACL."
  value       = aws_default_network_acl.default
}

output "default_route_table" {
  description = "The default route table."
  value       = aws_default_route_table.default
}
