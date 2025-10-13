module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  priv_subnet_cidr = var.priv_subnet_cidr
  pub_subnet_cidr = var.pub_subnet_cidr
}

module "ec2" {
  source = "./modules/compute"
  ami = var.ami
  instance_name = var.instance_name
  instance_type = var.instance_type
  key_name = var.key_name
  sg_id = module.vpc.vpc_sg
  pub_subnet_id = module.vpc.pub_subnet_id
}

