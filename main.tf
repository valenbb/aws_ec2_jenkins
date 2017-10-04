provider "aws" {}

resource "aws_security_group" "jenkins" {
  name        = "jenkins-ci-sg"
  description = "Jenkins CI security group"
  vpc_id      = "${var.vpc_id}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["74.109.185.9/32"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["74.109.185.9/32"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["74.109.185.9/32"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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
  security_groups = ["${aws_security_group.jenkins.name}"]
  
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