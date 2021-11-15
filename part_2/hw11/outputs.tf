output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "region" {
  value = data.aws_region.current.name
}

output "private_ip" {
  value = aws_instance.web.private_ip
}

output "primary_network_interface_id" {
  value = aws_instance.web.primary_network_interface_id
}
