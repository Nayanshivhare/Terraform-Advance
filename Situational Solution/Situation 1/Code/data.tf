# getting ami id
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

# getting list of az in a region
data "aws_availability_zones" "az" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }


}

# pass list of az into instance supported in the az
data "aws_ec2_instance_type_offerings" "example" {
  # for each can help you to iterate and it should be convereted into map or set
  for_each = toset(data.aws_availability_zones.az.names)
  filter {
    name   = "instance-type"
    values = [var.aws_instance]
  }
  #each.key will iterate all the values
  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
}
