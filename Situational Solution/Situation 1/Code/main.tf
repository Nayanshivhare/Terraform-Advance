provider "aws" {
  region = var.aws_region

}

# Get instance implemented on available az
resource "aws_instance" "myec2_Instances" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_instance
  #Create EC2 Instance in all Availabilty Zones of a VPC  
  for_each          = toset(keys({ for az, instance in data.aws_ec2_instance_type_offerings.example : az => instance.instance_types if length(instance.instance_types) != 0 }))
  availability_zone = each.key # You can also use each.value because for list items each.key == each.value
  tags = {
    "Name" = "For-${each.key}"
  }
}


