
# Terraform Commands

### **Terraform workflow**



> This is the first command to run after writing a new config files. It is used to initilize working directory containing terraform config files. It downloades all the dependencies.

```ruby
1. terraform init
```

>This is a command that syntactically validate and make sure your configuration files is consistent

```ruby
2. terraform validate
```

> This command will create an execution plan about how your infrastructure will look like. So that you can look before applying.

```ruby
3. terraform plan
```

> This command apply your infrastrucutre on your cloud provider.

```ruby
4. terraform apply
```
> It will destory Terraform managed infrastructure.
```ruby
5. terraform destroy
```



### **Terraform Variables: List & Map** 

> It is very important to undertstand some basic data strucutre before jumping into creating 3-tier or multi-cloud infrastrucutre. And, for the terraform you only need to master list, map with loops.
However, it is important to learn different variable types that you can use within terraform. I have covered briefly.

1. **List(string)**: A list can be used to store data of any type, such as strings, numbers, or objects, and can be of any length. Elements in a list are usually accessed by their position or index within the list, with the first element typically having an index of 0.
    ```go
    # Ec2-Instance type -list
    variable "instance_type_list" {
    description = "EC2 Instnace Type"
    type = list(string)
    default = ["t3.micro", "t3.small"]
    }
    ```
2. **Map(string)**: A map is a data structure that allows you to associate values with keys. Maps are used to define a collection of related data, where each item is identified by a unique key. Maps can be used to store and manipulate data of different types, including strings, numbers, lists, and other maps.

    ```go
    # AWS EC2 Instance Type - Map
    variable "instance_type_map" {
    description = "EC2 Instnace Type"
    type = map(string)
    default = {
        "dev" = "t3.micro"
        "qa"  = "t3.small"
        "prod" = "t3.large"
    }
    }
    ```


### **Use of created list and map in our terraform**

```go
# to access list
resource "aws_instance" "my_instance" {
    ami= data.aws_ami.ubuntu.id
    instance_type = var.instance_type_list[0]
    count= 4  # meta argument, it will spin up for ec2 instances
  
}

#to accesss map
resource "aws_instance" "my_instance_map" {
    ami=data.aws_ami.ubuntu.id
    instance_type = var.instance_type_map["prod"]
    count= 4
  
}
```

### **Use of Loop with list and Map**

```go
# for loop with list
output "for_output_list" {
  description = "For Loop with List"
  value       = [for instance in aws_instance.my_instance : instance.private_ip]
}

#for loop with map
output "for_output_map" {
  description = "For Loop with Map"
  value       = { for instance in aws_instance.my_instance_map : instance.id => instance.public_dns }
}
```

> However, it is better to use Splat Operator it will simply return the list, above example are just a way of how we can use loop.
```go
output "splat_operator-output" {
  description = "Generalized Splat Expression"
  value       = aws_instance.my_instance[*].public_dns
}
```

### **For Running Terraform**
```Bash
# from your terminal run
terraform init

terraform validate

terraform plan

terraform apply

terraform destroy


