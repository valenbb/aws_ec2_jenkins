provider "aws" {}

resource "aws_instance" "docker" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "true"

  tags {
    Name = "docker"
    owner = "alalla"
    env = "dev"
    app = "docker"
    Builder = "Terraform"
  }

  availability_zone = "${var.az_id}"
  subnet_id         = "${var.subnet_id}"
  key_name          = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group}"]
  
  user_data = <<HEREDOC
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y yum-utils device-mapper-persistent-data lvm2
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install docker-ce
  sudo service docker start
  sudo chkconfig docker on
HEREDOC

}