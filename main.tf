provider "aws" {}

resource "aws_instance" "jenkins" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "false"

  tags {
    Name = "jenkins"
    owner = "alalla"
    env = "dev"
    app = "jenkins"
    Builder = "Terraform"
  }

  availability_zone = "${var.az_id}"
  subnet_id         = "${var.subnet_id}"
  key_name          = "${var.key_name}"
  security_groups = ["${var.security_group}"]
  
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install java-1.8.0",
      "sudo yum remove java-1.7.0-openjdk",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
      " sudo yum install jenkins -y",
      "sudo service jenkins start"

    ]
  }
}