variable "availability_zone_names" {
  type = list(string)
  default = ["us-west-1", "us-west-2"]
}

variable "default_config" {
  type = object({
    cpu_cnt         = number
    threads_per_cpu = number
  })
  sensitive = false
}

provider "aws" {
  alias = "aws_1"
  profile = "default"
  region  = var.availability_zone_names[0]
}

provider "aws" {
  alias = "aws_2"
  profile = "default"
  region  = var.availability_zone_names[1]
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

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_instance" "web" {
  count                = 1
  cpu_core_count       = var.availability_zone_names.cpu_cnt
  cpu_threads_per_core = var.availability_zone_names.threads_per_cpu
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"

  provider = aws.aws_2

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Simple Ubuntu ${count.index}"
  }
}