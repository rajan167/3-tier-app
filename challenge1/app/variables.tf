# Defining CIDR Block for VPC
variable app {
    default = "default-app"
}
variable bucket-name{
  default = "rajan-bucket"
}
variable "vpc_cidr" {
  description = "VPC CIDR range"
  default     = "12.0.0.0/16"
}
# Defining CIDR Block for 1st Subnet
variable "subnet1_cidr" {
  default = "12.0.1.0/24"
}
# Defining CIDR Block for 2nd Subnet
variable "subnet2_cidr" {
  default = "12.0.2.0/24"
}
# Defining CIDR Block for 3rd Subnet
variable "subnet3_cidr" {
  default = "12.0.3.0/24"
}
# Defining CIDR Block for 4th Subnet
variable "subnet4_cidr" {
  default = "12.0.4.0/24"
}
# Defining CIDR Block for 5th Subnet
variable "subnet5_cidr" {
  default = "12.0.5.0/24"
}
# Defining CIDR Block for 6th Subnet
variable "subnet6_cidr" {
  default = "12.0.6.0/24"
}
#key pair name for ec2 instances
variable keypair{
    default = "app"
    }
# Map containing ec2 details for creation
variable "instance_details" {
  type = map(object({
    instance_type = string
    availability_zone = string
    tags          = map(string)
  }))
  default = {
    instance1 = {
      instance_type = "t2.medium"  # Change this to your desired instance type
      availability_zone = "us-east-1b"
      subnet_id = "demo-id"
      tags = {
        Name = "Public Instance 1"
      }
    },
    instance2 = {
      instance_type = "t2.medium"  # Change this to your desired instance type
      availability_zone = "us-east-1b"
      tags = {
        Name = "Public Instance 2"
      }
    }
    # Add more instances here if needed
  }
}