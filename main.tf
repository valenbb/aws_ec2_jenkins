provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_security_group" "jenkins" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["74.109.185.9/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["74.109.185.9/32"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["74.109.185.9/32"]
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "jenkins-sg"
    owner = "alalla"
    env = "dev"
    app = "jenkins"
    Builder = "Terraform"
  }
}

resource "aws_instance" "jenkins" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.instance_type}"

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
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  user_data       = "${file("jenkins.sh")}"
  
}