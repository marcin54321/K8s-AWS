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

resource "aws_security_group" "k8s" {
  name        = "allow-all-k8s"
  description = "Security group for instances that allows the whole internal traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.10.0/24"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.10.0/24"]
  }

  tags = {
    Name = "sg-allow-internal-all"
  }
}

