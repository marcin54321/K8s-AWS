variable "subnet_id" {
  type = string
}

variable "sg_ssh_id" {
  type = string
}

variable "sg_all_id" {
  type = string
}

variable "sg_k8s_id" {
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
    var.sg_ssh_id,
    var.sg_all_id,
    var.sg_k8s_id
  ]

  tags = {
    Name = "master-${count.index}"
  }

  subnet_id = var.subnet_id

  associate_public_ip_address = true

  provisioner "local-exec" {
    command = <<EOT
      sleep 60;
      >master-inventory.ini;
      echo "[masters]" | tee -a master-inventory.ini;
      echo "${self.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a master-inventory.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
      ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i master-inventory.ini ../ansible/master-playbook.yaml --extra-vars "index=${count.index}"
    EOT
  }
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
    var.sg_ssh_id,
    var.sg_all_id,
    var.sg_k8s_id
  ]

  tags = {
    Name = "worker-${count.index}"
  }

  subnet_id = var.subnet_id

  associate_public_ip_address = true

  provisioner "local-exec" {
    command = <<EOT
      sleep 60;
      >worker-inventory.ini;
      echo "[worker]" | tee -a worker-inventory.ini;
      echo "${self.public_ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.private_key}" | tee -a worker-inventory.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
      ansible-playbook -u ${var.ansible_user} --private-key ${var.private_key} -i worker-inventory.ini ../ansible/worker-playbook.yaml --extra-vars "index=${count.index}"
    EOT
  }
}

