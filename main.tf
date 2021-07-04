# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-${var.instance_arch}-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key-pair-${var.aws_region}"
  public_key = file("${var.public_key_path}")
  tags = {}
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # associate_public_ip_address = true
  # vpc_security_group_ids = [aws_security_group.app-sg.name]
  vpc_security_group_ids = [aws_security_group.app-sg.id]
  key_name               = "terraform-key-pair-${var.aws_region}"

  tags = {
    Name = var.instance_name
  }

  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("${var.private_key_path}")
      host = "${aws_instance.app_server.public_ip}"
    }
  }

  provisioner "remote-exec" {
    inline = ["touch test.txt"]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("${var.private_key_path}")
      host = "${aws_instance.app_server.public_ip}"
    }
  }

  #############################################################################
  # Ansible runs from the same host you run Terraform from - could also update 
  # this later to rather run Ansible on the remote host.
  #############################################################################

  provisioner "local-exec" {
    command = "echo '---\ntfHosts:\n  hosts:\n    tfHost1:\n      ansible_host: ${aws_instance.app_server.public_ip}\n  vars:\n    ansible_user: ${var.ssh_user}' > ansible/inventoryTf"
  }

  provisioner "local-exec" {
    command = "cd ansible/;ansible-playbook -i ./inventoryTf --private-key ${var.private_key_path} ./playbook.yml"
  }

}

resource "aws_security_group" "app-sg" {
  name        = "terraform_SG_${var.aws_region}"
  description = "Security group description"
  tags = {}
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_src_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
