# vpc
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "${var.vpc_name}-igw"
    }
}

# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  count = length(var.pub_subnet_cidr)
  availability_zone = element(var.az, count.index)
  cidr_block = element(var.pub_subnet_cidr, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
      Name = element(var.pub_subnet, count.index)
  }
}

# private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
   count = length(var.priv_subnet_cidr)
  availability_zone = element(var.az, count.index)
  cidr_block = element(var.priv_subnet_cidr, count.index)
  tags = {
    Name = element(var.priv_subnet, count.index)
  }
}

#provides an Elastic IP resource
resource "aws_eip" "nat_eip" {
    domain = var.domain
    count = length(var.pub_subnet_cidr)
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
      Name = "Elastic IP- ${var.pub_subnet[count.index]}"
    }
}

#provides a resource to create a VPC NAT Gateway
resource "aws_nat_gateway" "public_nat_gateway" {
    count = length(var.priv_subnet_cidr)
    subnet_id = aws_subnet.public_subnet[count.index].id 
    allocation_id = aws_eip.nat_eip[count.index].id
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
      Name = "NAT gateway- ${var.pub_subnet[count.index]}"
    }
}

#public route table
resource "aws_route_table" "pub_rtb" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = var.rtb_cidr
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "${var.vpc_name}-pub-rtb"
    }
}

#private route table
resource "aws_route_table" "priv_rtb" {
    vpc_id = aws_vpc.main.id
    count = length(var.priv_subnet_cidr)
    route {
        cidr_block = var.rtb_cidr
        nat_gateway_id = aws_nat_gateway.public_nat_gateway[count.index].id
    }
    tags = {
      Name = "${var.vpc_name}-priv-rtb"
    }
} 

#public route table association
#Provides a resource to create an association between a route table and a subnet or a route table and an internet gateway
resource "aws_route_table_association" "public_rtb_association" {
    route_table_id = aws_route_table.pub_rtb.id
    count = length(var.pub_subnet_cidr)
    subnet_id = aws_subnet.public_subnet[count.index].id
    depends_on = [ aws_subnet.public_subnet, aws_route_table.pub_rtb ]
}

#private route table association
resource "aws_route_table_association" "private_rtb_association" {
    route_table_id = aws_route_table.priv_rtb[count.index].id
    count = length(var.priv_subnet_cidr)
    subnet_id = aws_subnet.private_subnet[count.index].id
    depends_on = [ aws_subnet.private_subnet, aws_route_table.priv_rtb ]
}

#security group for the instance 
resource "aws_security_group" "instance_sg" {
    vpc_id = aws_vpc.main.id # put sg in vpc module

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # defines who is allowed to initiate the connection (the source)
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.vpc_name}-sg"
    }
}