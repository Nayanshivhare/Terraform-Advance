# get instance list
output "output_v1_1" {
  # output should be in for loop for list of supported instances
  value = [for instance in data.aws_ec2_instance_type_offerings.example : instance.instance_types]
}

# now lets see how we can get available instance type with az as a output
output "output_v1_1" {

  value = { for az, instance in data.aws_ec2_instance_type_offerings.example : az => instance.instance_types }
}


# remove unsupported az and only get supported ec2 instance with az
output "output_v1_2" {

  value = { for az, instance in data.aws_ec2_instance_type_offerings.example : az => instance.instance_types if length(instance.instance_types) != 0 }

}


# only getting list of az using key function
output "availability_zone_that_supported_instance_type" {

  value = keys({ for az, instance in data.aws_ec2_instance_type_offerings.example : az => instance.instance_types if length(instance.instance_types) != 0 })

}

# get public dns of our instances
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"

  value = toset([for instance in aws_instance.myec2_Instances : instance.public_dns])
}
