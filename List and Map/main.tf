provider "aws" {
  region = "us-east-1"

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

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical official
}

# to access list
resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type_list[0]
  count         = 3


}

#to accesss map
resource "aws_instance" "my_instance_map" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type_map["prod"]
  count         = 4

}


# for loop list output
output "for_output_list" {
  description = "For Loop with List"
  value       = [for instance in aws_instance.my_instance : instance.private_ip]
}

# for loop map output
output "for_output_map" {
  description = "For Loop with Map"
  value       = { for instance in aws_instance.my_instance_map : instance.id => instance.public_dns }
}


# Splat operator
output "splat_operator-output" {
  description = "Generalized Splat Expression"
  value       = aws_instance.my_instance[*].public_dns
}



