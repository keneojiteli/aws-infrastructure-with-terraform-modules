#ec2 instance for the bastion server, located in the public subnet
resource "aws_instance" "instance" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.pub_subnet_id # child -child module dependency
    vpc_security_group_ids = var.sg_id # child -child module dependency, use argument ref bcos instance is created in a vpc 
    key_name = var.key_name
    tags = {
        Name = var.instance_name
    }
}

