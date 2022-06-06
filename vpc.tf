resource "aws_vpc" "sscp_vpc_stg" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "${var.website_name}-vpc-${var.env}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.sscp_vpc_stg.id

  tags = {
    Name        = "${var.website_name}-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.sscp_vpc_stg.id
  cidr_block              = "10.0.${10 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.website_name}-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.sscp_vpc_stg.id
  cidr_block              = "10.0.${20 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.website_name}-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.sscp_vpc_stg.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }
}

resource "aws_main_route_table_association" "rt_main" {
  vpc_id         = aws_vpc.sscp_vpc_stg.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "public_rt" {
  for_each = { for name, subnet in aws_subnet.public_subnet : name => subnet if length(regexall("public-", name)) > 0 }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "private_rt" {
  for_each = { for name, subnet in aws_subnet.private_subnet : name => subnet if length(regexall("public-", name)) > 0 }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}


resource "aws_security_group" "sg_bastion" {
  name   = "${var.website_name}-sg-bastion-${var.env}"
  vpc_id = aws_vpc.sscp_vpc_stg.id

  dynamic "ingress" {
    for_each = toset(local.catena_mt_office)
    content {
      description = "SSH Access from VPN"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = toset(local.crownpeak)
    content {
      description = "SSH Access from VPN"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = toset(local.P81TechOps)
    content {
      description = "SSH Access from VPN"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  ingress {
    cidr_blocks = ["13.90.129.89/32"]
    description = "Ahmed Hossam IP"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }
}

resource "aws_security_group" "cloudflare_access_sg" {
  name   = "${var.website_name}-sg-${var.env}"
  vpc_id = aws_vpc.sscp_vpc_stg.id

  dynamic "ingress" {
    for_each = toset(local.cf_ipv4)
    content {
      description = "HTTPS Access from CF IPv4"
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = toset(local.cf_ipv6)
    content {
      description = "HTTPS Access from CF IPv6"
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name        = "${var.website_name}-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_security_group" "internal_access_sg" {
  name   = "${var.website_name}-sg-${var.env}"
  vpc_id = aws_vpc.sscp_vpc_stg.id

  ingress {
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
    from_port   = "0"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["18.102.30.36/32"]
    description = "Bastion host connectivity"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name        = "${var.website_name}-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}

resource "aws_security_group" "vpn_office_access_sg" {
  name   = "${var.website_name}-sg-${var.env}"
  vpc_id = aws_vpc.sscp_vpc_stg.id

  dynamic "ingress" {
    for_each = toset(local.catena_mt_office)
    content {
      description = "SSH Access from VPN"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = toset(local.P81TechOps)
    content {
      description = "SSH Access from VPN"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name        = "${var.website_name}-${var.env}"
    Environment = var.env
    Project     = var.project_name
  }
}