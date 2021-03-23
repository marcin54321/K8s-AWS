resource "aws_security_group" "ssh" {
  name        = "allow-ingress-ssh"
  description = "Security group for instances that allows SSH traffic from internet"

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

resource "aws_security_group" "all" {
  name        = "allow-egress-all"
  description = "Security group for instances that allows egress traffic towards internet"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-allow-egress-all"
  }
}
