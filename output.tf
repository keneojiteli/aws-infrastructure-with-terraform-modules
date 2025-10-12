output "vpc" {
  value = module.vpc.vpc_id
}

output "pub_subnet"{
    value = module.vpc.pub_subnet_id
}

output "priv_subnet"{
  value = module.vpc.priv_subnet_id
}

output "security_group" {
  value = module.vpc.vpc_sg
}