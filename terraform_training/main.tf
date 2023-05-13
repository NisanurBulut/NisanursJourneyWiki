// Provider

provider "aws" {
  access_key = ""
  secret_key = ""
  region = "eu-west-1"
}

// Virtual Private Cloud (VPC)

resource "aws_vpc" "default_nb_vpc_resource" {
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true
  tags {
    Name="terraform_aws_vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id = "${aws_vpc.default_nb_vpc_resource.id}"
  cidr_block="172.31.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    "Name" = "public"
  }
}
// Security Group
resource "aws_security_group" "public" {
    name = "public"
    description = "Allow traffic to pass from the public subnet to the internet"
    vpc_id = "${aws_vpc.default_nb_vpc_resource.id}"
    
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    // for ping
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    // for ping
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
tags {
        Name = "public"
    }
}