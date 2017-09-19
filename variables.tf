variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Desired instance type for EC2"
  default = "t2.medium"
}

# CentOS 7
variable "aws_ami" {
  default = "ami-2bd53851"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "jenkins_user"
}

variable "private_key_path" {
  description = "Enter the path to the SSH Private Key to run provisioner."
  default = "/var/lib/jenkins/.ssh/id_rsa"
}

variable "vpc_id" {
  description = "Production VPC ID"
  default = "vpc-932cb8f6"
}

variable "subnet_id" {
  description = "Subnet ID to use"
  default = "subnet-adbc6cf4"
}

variable "az_id" {
  description = "Availability Zone"
  default = "us-east-1b"
}

variable "security_group" {
  description = "Jenkins Security Group"
  default = "sg-f7558f86"
}