output "instance_ip" {
  value = ["${aws_instance.jenkins.*.private_ip}"]
}
