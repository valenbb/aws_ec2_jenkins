output "instance_ip1" {
  value = ["${aws_instance.docker.*.private_ip}"]
}
