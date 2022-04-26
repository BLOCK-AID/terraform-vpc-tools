# Create the VPC
resource "aws_vpc" "Main" {                # Creating VPC here
    cidr_block       = var.main_vpc_cidr     # Defining the CIDR block use 10.0.0.0/24 for demo
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.name_prefix}-tools"
    }
}

#  Create Internet Gateway and attach it to VPC
resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
    tags = {
        Name = "${var.name_prefix}-tools"
    }
}

#  Create Public Subnet-1
resource "aws_subnet" "publicsubnets_1" {    # Creating Public Subnets
    vpc_id =  aws_vpc.Main.id
    cidr_block = "${var.public_subnets_1}"        # CIDR block of public subnets
    tags = {
        Name = "${var.name_prefix}-public-tools"
    }
}

#  Create Public Subnet-2
resource "aws_subnet" "publicsubnets_2" {    # Creating Public Subnets
    vpc_id =  aws_vpc.Main.id
    cidr_block = "${var.public_subnets_2}"        # CIDR block of public subnets
    tags = {
        Name = "${var.name_prefix}-public-tools"
    }
}

#  Create a Private Subnet-1                   # Creating Private Subnets
resource "aws_subnet" "privatesubnets_1" {
    vpc_id =  aws_vpc.Main.id
    cidr_block = "${var.private_subnets_1}"          # CIDR block of private subnets
    tags = {
        Name = "${var.name_prefix}-private-tools"
    }
}

#  Create a Private Subnet-2                   # Creating Private Subnets
resource "aws_subnet" "privatesubnets_2" {
    vpc_id =  aws_vpc.Main.id
    cidr_block = "${var.private_subnets_2}"          # CIDR block of private subnets
    tags = {
        Name = "${var.name_prefix}-private-tools"
    }
}

#  Route table for Public Subnet's
resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Main.id
    route {
        cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
        gateway_id = aws_internet_gateway.IGW.id
    }
    tags = {
        Name = "${var.name_prefix}-public-tools"
    }
}

#  Route table for Private Subnet's
resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
    vpc_id = aws_vpc.Main.id
    route {
        cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
        nat_gateway_id = aws_nat_gateway.NATgw.id
    }
    tags = {
        Name = "${var.name_prefix}-private-tools"
    }
 }

#  Route table Association with Public Subnet's
resource "aws_route_table_association" "PublicRTassociation" {
    subnet_id = aws_subnet.publicsubnets_1.id
    route_table_id = aws_route_table.PublicRT.id
 }
#  Route table Association with Private Subnet's
 resource "aws_route_table_association" "PrivateRTassociation" {
    subnet_id = aws_subnet.privatesubnets_1.id
    route_table_id = aws_route_table.PrivateRT.id
 }
 resource "aws_eip" "nateIP" {
   vpc   = true
 }
#  Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets_1.id
 }