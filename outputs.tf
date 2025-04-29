output "public_instance_ip" {
  value = module.vpc_setup.public_instance_ip
}

output "private_instance_id" {
  value = module.vpc_setup.private_instance_id
}
