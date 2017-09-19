provider "aws" {}

resource "aws_instance" "docker" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.instance_type}"

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
  
  connection {
    user = "centos"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum -y install nginx",
      "sudo service nginx start",
    ]
  }
}