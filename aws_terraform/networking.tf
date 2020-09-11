provider "aws" {
    region = var.AWS_REGION
    access_key = var.access_key
    secret_key = var.secret_key
}

resource "aws_vpc" "mainvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name = join("-", [var.owner, "sec-clus-vpc"])
    }
}

// get the deployer ip address
data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.body)
}


resource "aws_internet_gateway" "sec-clus-igw" {
    // get the deployer ip address
    vpc_id = aws_vpc.mainvpc.id
    
    tags = {
        Name = join("-", [var.owner, "sec-clus-ig"])
    }    
}

resource "aws_route_table" "sec-clus-route" {
    vpc_id = aws_vpc.mainvpc.id
    route {
        cidr_block = "0.0.0.0/0" //associated subnet can reach everywhere
        gateway_id = aws_internet_gateway.sec-clus-igw.id 
    }

    tags = {
        Name = join("-", [var.owner, "sec-clus-ig"])
    }
}

resource "aws_subnet" "mainsubnet" {
    vpc_id = aws_vpc.mainvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
}

resource "aws_route_table_association" "sec-clus-subnet-1" {
    subnet_id = aws_subnet.mainsubnet.id
    route_table_id = aws_route_table.sec-clus-route.id
}

resource "aws_security_group" "sec-clus-sg" {

    vpc_id = aws_vpc.mainvpc.id

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        
        //ipv6_cidr_blocks = ["${local.ifconfig_co_json.ip}/128"]
        cidr_blocks = concat(["${local.ifconfig_co_json.ip}/32"], var.ingress_cidr_blocks)
    }

    //If you do not add this rule, you can not reach the NGIX
    ingress {
        from_port = 0
        to_port = 0
        protocol = -1

        //ipv6_cidr_blocks = ["${local.ifconfig_co_json.ip}/128"]
        cidr_blocks = concat(["${local.ifconfig_co_json.ip}/32"], var.ingress_cidr_blocks)
    }

    tags = {
        Name = join("-", [var.owner, "sec-clus-ig"])
    }
}

