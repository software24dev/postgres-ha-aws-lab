output "instance_details" {
  description = "EC2 instance details"
  value = {
    for name, instance in aws_instance.ha :
    name => {
      instance_id   = instance.id
      private_ip    = instance.private_ip
      public_ip     = instance.public_ip
      instance_type = instance.instance_type
    }
  }
}

output "security_group_id" {
  description = "HA lab security group ID"
  value       = aws_security_group.ha.id
}
