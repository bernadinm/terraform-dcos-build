# This file was generated by `yo terraform-module` using template v1.0.0, hash: 2c31eb427982593fba08e88d991b38e5)

##
# outputs for `resource`
##
output "private_ip" {
  value = "${aws_instance.worker.private_ip}"
}

output "public_ip" {
  value = "${aws_instance.worker.public_ip}"
}
