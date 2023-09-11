resource "aws_vpc" "waiphyo_dev_vpc" {
    provider = aws.dev
    cidr_block = var.dev_vpc_cidr
    tags = {
        Name = var.vpc_name
    }
    enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
    depends_on = [ 
        aws_vpc.waiphyo_dev_vpc,
     ]
    provider = aws.dev
    cidr_block = var.public_subnet
    availability_zone = var.az
    vpc_id = aws_vpc.waiphyo_dev_vpc.id
    tags = {
      Name = var.public_subent_name
    }
}

resource "aws_internet_gateway" "waiphyo_dev" {
    depends_on = [ 
        aws_vpc.waiphyo_dev_vpc,
     ]
    vpc_id = aws_vpc.waiphyo_dev_vpc.id
    provider = aws.dev
    tags = {
      Name = var.igw_name
    }
}

resource "aws_route_table" "waiphyo_public_route" {
    depends_on = [ 
        aws_vpc.waiphyo_dev_vpc,
        aws_internet_gateway.waiphyo_dev,
     ]
    vpc_id = aws_vpc.waiphyo_dev_vpc.id
    provider = aws.dev
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.waiphyo_dev.id
    }
    tags = {
      Name = var.pub_route
    }
}

resource "aws_route_table_association" "waiphyo_dev" {
    depends_on = [ 
        aws_subnet.public_subnet,
        aws_route_table.waiphyo_public_route,
     ]
    provider = aws.dev
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.waiphyo_public_route.id
  
}

resource "aws_subnet" "private_subnet" {
    provider = aws.dev
    depends_on = [ 
        aws_vpc.waiphyo_dev_vpc,
     ]
    vpc_id = aws_vpc.waiphyo_dev_vpc.id
    cidr_block = var.private_cidr
    availability_zone = var.az
    tags = {
      Name = var.private_subent_name
    }
}

resource "aws_eip" "elastic_ip" {
    provider = aws.dev
    domain = "vpc"
    tags = {
      Name = "nat_ip"
    }
}

resource "aws_nat_gateway" "waiphyo_dev" {
    provider = aws.dev
    depends_on = [ 
        aws_vpc.waiphyo_dev_vpc,
        aws_subnet.public_subnet,
        aws_eip.elastic_ip,
     ]
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.elastic_ip.id
    tags = {
      Name = var.nat_name
    }
  
}

resource "aws_route_table" "nat_route" {
    provider = aws.dev
    depends_on = [ 
        aws_nat_gateway.waiphyo_dev,
        aws_vpc.waiphyo_dev_vpc,
     ]
    vpc_id = aws_vpc.waiphyo_dev_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.waiphyo_dev.id
    }
    tags = {
      Name = var.nat_route_table_name
    }
}

resource "aws_route_table_association" "nat_route_associate" {
    provider = aws.dev
    depends_on = [ 
        aws_vpc.waiphyo_dev_vpc,
        aws_nat_gateway.waiphyo_dev,
        aws_route_table.nat_route,
     ]
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.nat_route.id
  
}