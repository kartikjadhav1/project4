terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.12.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
# this is a hardcoded vpc with cidr block as given below 
resource "aws_vpc" "kjmyvpc" {
  cidr_block = "10.10.0.0/16"

}

resource "aws_subnet" "pub_sub" {
  vpc_id            = aws_vpc.kjmyvpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"

}

resource "aws_subnet" "priv_sub" {
  vpc_id            = aws_vpc.kjmyvpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "us-east-1b"

}

resource "aws_internet_gateway" "kj_igw01" {
  vpc_id = aws_vpc.kjmyvpc.id
}

resource "aws_route_table" "custom_main_rtb" {
  vpc_id = aws_vpc.kjmyvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kj_igw01.id

  }

}

resource "aws_route_table_association" "pub_sub_assoc" {
  subnet_id = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.custom_main_rtb.id
  
}
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "nat_gw"{
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.pub_sub.id
  depends_on = [aws_internet_gateway.kj_igw01]

}

resource "aws_route_table" "custom_priv_table" {
  vpc_id = aws_vpc.kjmyvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "priv_sub_assoc" {
  subnet_id = aws_subnet.priv_sub.id
  route_table_id = aws_route_table.custom_priv_table.id
}