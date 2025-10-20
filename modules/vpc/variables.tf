#best practice: stick to underscores in variable names to avoid needing quotes
variable "region" {
   description = "Region for tf-project"
   type = string
   default = "us-east-1"
}

variable "vpc_name" {
    description = "Name of the VPC"
    type = string
    default = "tf-proj-vpc" 
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "enable_dns_hostnames" {
    description = "Enable DNS hostnames in the VPC"
    type = bool
    default = true  
}

variable "instance_tenancy" {
    description = "Instance tenancy option for the VPC"
    type = string
    default = "default"
  
}

variable "map_public_ip_on_launch" {
    description = "Map public IP on launch for public subnets"
    type = bool
    default = true   
}

variable "az" {
    description = "Availability zone to provision network infra"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"] 
}

variable "priv_subnet_cidr" {
    description = "Private subnet CIDR block"
    type = list(string)
}

variable "pub_subnet_cidr" {
    description = "Public subnets CIDR block"
    type = list(string)
}

variable "priv_subnet" {
    description = "Private subnets for high availability"
    type = list(string)
    default = [ "priv-subnet-1", "priv-subnet-2" ]
}

variable "pub_subnet" {
    description = "Public subnets for high availability"
    type = list(string)
    default = [ "pub-subnet-1", "pub-subnet-2" ]
}

variable "domain" {
    description = "Domain for the Elastic IP"
    type = string
    default = "vpc"
}

variable "rtb_cidr" {
    description = "CIDR block for the route table"
    type = string
    default = "0.0.0.0/0" 
}