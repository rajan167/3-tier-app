module "app" {
  source        = "./app"
  app = "3-tier-app"
  bucket-name = "test-bucket167" # Bucket name for S3
  vpc_cidr = "11.0.0.0/16" # VPC CIDR
  subnet1_cidr= "11.0.1.0/24" # Subnet CIDR
  subnet2_cidr= "11.0.2.0/24" # Subnet CIDR
  subnet3_cidr= "11.0.3.0/24" # Subnet CIDR
  subnet4_cidr= "11.0.4.0/24" # Subnet CIDR
  subnet5_cidr= "11.0.5.0/24" # Subnet CIDR
  subnet6_cidr= "11.0.6.0/24" # Subnet CIDR
  keypair = "three-tier-app" # PEM key used for accessing EC2
  instance_details = { 
    instance1 = {
        instance_type = "t2.micro"           # Replace with the desired instance type for instance 1
        availability_zone = "us-east-1a"     # Availability zone where you want to provision the instance 1
        tags = {
         Name = "Instance 1"
        }
    },
    instance2 = {
        instance_type = "t2.micro"           # Replace with the desired instance type for instance 2
        availability_zone = "us-east-1b"     # Availability zone where you want to provision the instance 2
        tags = {
        Name = "Instance 2"
        }
    }
    }
    # Add more instances here if needed
}
