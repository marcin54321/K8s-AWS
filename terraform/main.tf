terraform {
  required_version = ">= 0.12.00"
}

module "key_pair" {
  source = "./modules/aws_key_pair"
}

module "subnet" {
  source = "./modules/aws_subnet"
}

module "security_group" {
  source = "./modules/aws_security_group"
}

module "ec2_instance" {
  source = "./modules/aws_ec2_instance"
  subnet_id = module.subnet.subnet_id
  sg_ssh_id = module.security_group.sg_ssh_id
  sg_all_id = module.security_group.sg_all_id
}
