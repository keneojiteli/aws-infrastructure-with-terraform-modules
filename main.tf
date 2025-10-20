module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  priv_subnet_cidr = var.priv_subnet_cidr
  pub_subnet_cidr = var.pub_subnet_cidr
  priv_subnet = var.priv_subnet
  pub_subnet = var.pub_subnet
}

module "ec2" {
  source = "./modules/compute"
  ami = var.ami
  instance_name = var.instance_name
  instance_type = var.instance_type
  key_name = var.key_name
  sg_id = [module.vpc.vpc_sg]
  pub_subnet_id = module.vpc.pub_subnet_id
}

module "rds" {
  source = "./modules/db"
  az = var.az
  id = var.id
  db_engine = var.db_engine
  db_eng_version = var.db_eng_version
  instance_class = var.instance_class
  storage = var.storage
  db_username = var.db_username
  db_password = var.db_password
  db_name = var.db_name
  subnet_grp_name = var.subnet_grp_name
  priv_subnet = module.vpc.priv_subnet_id
  sg = [module.vpc.vpc_sg]
}
