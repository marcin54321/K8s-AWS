resource "aws_security_group" "ssh" {
  name        = "allow-ingress-ssh"
  description = "Security group for nat instances that allows SSH traffic from internet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-allow-ingress-ssh"
  }
}

