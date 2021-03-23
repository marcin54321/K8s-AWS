output "sg_ssh_id" {
  value = aws_security_group.ssh.id
}

output "sg_all_id" {
  value = aws_security_group.all.id
}
