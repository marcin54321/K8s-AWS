output "sg_ssh_id" {
  value = aws_security_group.ssh.id
}

output "sg_all_id" {
  value = aws_security_group.all.id
}

output "sg_k8s_id" {
  value = aws_security_group.k8s.id
}

