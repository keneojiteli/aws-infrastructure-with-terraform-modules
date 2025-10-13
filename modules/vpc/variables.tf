#best practice: stick to underscores in variable names to avoid needing quotes
variable "region" {
   description = "Region for tf-project"
   type = string
   default = "us-east-1"
}

variable "vpc_name" {
    description = "Name of the VPC"
    type = string
    default = "b2w-vpc" 
}

variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
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

variable "availability_zone" {
    description = "Availability zone to provision network infra"
    type = string
    default = "us-east-1a" 
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