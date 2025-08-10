
provider "aws" {
  region = "us-east-1"
}

# 1. VPC
resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "lab-vpc"
  }
}

# 2. Subnets

# 2.1 Pública 1
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "lab-subnet-public1-us-east-1a"
  }
}
# 2.2 Privada 1
resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "lab-subnet-private1-us-east-1a"
  }
}
# 2.3 Pública 2
resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "lab-subnet-public2"
  }
}
# 2.4 Privada 2
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.lab_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "lab-subnet-private2"
  }
}

# 3. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "lab-igw"
  }
}

# Elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "lab-nat_eip"
  }
}

# NAT Gateway en public1
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "lab-nat-public1-us-east-1a"
  }
}

# 5. Tabla de rutas pública
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "lab-rtb-public"
  }
}

# 6. Tabla de rutas privada
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "lab-rtb-private1-us-east-1a"
  }
}

# 7. Asociación de tabla de rutas con subred
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}

# 8. Grupo de seguridad
resource "aws_security_group" "web_sg" {
  name        = "Web Security Group"
  description = "Enable HTTP access"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "Permit web requests"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Security Group"
  }
}

# 9 Instancia ec2
resource "aws_instance" "web_server" {
  ami           = "ami-0de716d6197524dd9" # Amazon Linux 2023 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public2.id
  associate_public_ip_address = true
  key_name      = "vockey"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    dnf install -y httpd wget php mariadb105-server unzip
    wget https://aws-tc-largeobjects.s3.us-west-2.amazonaws.com/CUR-TF-100-ACCLFO-2/2-lab2-vpc/s3/lab-app.zip
    unzip lab-app.zip -d /var/www/html/
    chkconfig httpd on
    service httpd start
  EOF

  tags = {
    Name = "Web Server 1"
  }
}

# 10 Imprimir DNS de la instancia EC2

output "web_server_public_dns" {
  description = "DNS público de la instancia web"
  value       = aws_instance.web_server.public_dns
}
