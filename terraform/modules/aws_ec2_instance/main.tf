variable "subnet_id" {
  type = string
}

variable "sg_ssh_id" {
  type = string
}

resource "aws_instance" "master" {
  count = var.master_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "MyKeyPair"

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 8
  }

  connection {
    host = self.public_ip
    private_key = file(var.private_key)
    user        = var.ansible_user
  }

  provisioner "remote-exec" {
    inline = ["sudo apt-get install python3 -y"]
  }

  vpc_security_group_ids = [
    var.sg_ssh_id
  ]

  tags = {
    Name = "master-${count.index}"
  }

  subnet_id = var.subnet_id

  associate_public_ip_address = true
}

resource "aws_instance" "worker" {
  count = var.worker_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name = "MyKeyPair"

  ebs_block_device {
    device_name           = "/dev/sdg"
    volume_size           = 8
  }

  connection {
    host = self.public_ip
    private_key = file(var.private_key)
    user        = var.ansible_user
  }

  provisioner "remote-exec" {
    inline = ["sudo apt-get install python3 -y"]
  }

  vpc_security_group_ids = [
    var.sg_ssh_id
  ]

  tags = {
    Name = "worker-${count.index}"
  }

  subnet_id = var.subnet_id

  associate_public_ip_address = true
}

