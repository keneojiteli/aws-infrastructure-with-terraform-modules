variable "region" {
   description = "Region for tf-project"
   type = string
   default = "us-east-1"
}

# vpc module vars
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "priv_subnet_cidr" {
    description = "Private subnet CIDR block"
    type = string
    default = "10.0.1.0/24" 
}

variable "pub_subnet_cidr" {
    description = "Public subnets CIDR block"
    type = string
    default = "10.0.3.0/24" 
}

# ec2 module vars
variable "ami" {
    type = string
    default = "ami-052064a798f08f0d3"
}

variable "instance_type" {
    type = string 
    default = "t2.micro"
}

variable "key_name" {
    type = string 
    default = "kene-devops-key"
  
}

variable "instance_name" {
    description = "EC2 instance name"
    type = string
    default = "tf-instance" 
}

# variable "pub_subnet_id" {
#     type = string
# }

# variable "sg_id" {
#     type = string
# }

# # db module vars
# variable "subnet_grp_name" {
#   description = "Db subnet group name"
#   type = string
# }

# variable "id" {
#   type = string
#   default = "postgres-db" 
# }

# variable "db_engine" {
#   description = "DB engine to use"
#   type = string
#   default = "postgres"
# }

# variable "db_eng_version" {
#   description = "DB engine supported version to use"
#   type = string
#   default = "16.6"
# }

# variable "instance_class" {
#   description = "Instance class of the DB instance"
#   type = string
#   default = "db.t4g.micro"
# }

# variable "storage" {
#   description = "Allocated storage in gibibytes"
#   type = number
#   default = 20
# }

# variable "db_username" {
#   description = "RDS database username"
#   type        = string 
#   default = "terraform-proj-user" 
# }

# variable "db_password" {
#   description = "RDS database password"
#   type        = string
#   sensitive = true
# }

# variable "db_name" {
#   description = "RDS database name"
#   type        = string
#   default = "terraform-proj-db"
# }