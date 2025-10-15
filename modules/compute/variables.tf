#best practice: stick to underscores in variable names to avoid needing quotes
variable "ami" {
    description = "AMI for EC2"
    type = string
}

variable "instance_type" {
    description = "Instance type for EC2"
    type = string 
}

variable "key_name" {
    description = "Key pair name for EC2"
    type = string 
  
}

variable "instance_name" {
    description = "EC2 instance name"
    type = string
    default = "tf-instance" 
}

variable "pub_subnet_id" {
    description = "Subnet where EC2 will be provisioned: public subnet"
    type = string
}

variable "sg_id" {
    description = "Security group for instance"
    type = list(string) 
    # type = string
}
