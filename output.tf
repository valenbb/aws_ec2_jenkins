output "instance_ip1" {
  value = ["${aws_instance.docker.*.private_ip}"]
}

output "instance_ip2" {
  value = ["${aws_instance.docker.*.public_ip}"]
}