#variable "vpc_id" {
#  type = string
#}

resource "aws_subnet" "k8s_subnet" {
  cidr_block = "172.31.10.0/24"
  vpc_id = var.vpc_id
  tags = {
    Name = "k8s_subnet"
  }
}
