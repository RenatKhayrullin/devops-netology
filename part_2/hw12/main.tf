variable "default_config" {
  type = object({
    cpu_cnt         = number
    threads_per_cpu = number
  })
  sensitive = false
}

locals {
  web_instance_type_map = {
    stage = "t3.micro"
    prod = "t3.large"
  }

  web_instance_count_map = {
    stage = 1
    prod = 2
  }
}

variable "availability_zone_names" {
  type = list(string)
  default = ["us-west-1", "us-west-2"]
}

provider "aws" {
  profile = "default"
  region  = var.availability_zone_names[0]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "web_1" {
  count                = local.web_instance_count_map[terraform.workspace]
  cpu_core_count       = var.availability_zone_names.cpu_cnt
  cpu_threads_per_core = var.availability_zone_names.threads_per_cpu
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = local.web_instance_type_map[terraform.workspace]

  provider = aws.aws

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Simple Ubuntu ${count.index}"
  }
}

resource "aws_instance" "web_2" {
  count                = local.web_instance_count_map[terraform.workspace]
  cpu_core_count       = var.availability_zone_names.cpu_cnt
  cpu_threads_per_core = var.availability_zone_names.threads_per_cpu
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = local.web_instance_type_map[terraform.workspace]

  provider = aws.aws

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Simple Ubuntu ${count.index}"
  }
}