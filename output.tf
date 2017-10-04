output "instance_ip" {
  value = ["${aws_instance.docker.*.private_ip}"]
}
