# this will fetch the latest amazon linux ami value from AWS
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"] # You can customize the filter pattern if needed
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  /*filter {
    name   = "tag:aws:FreeTier"
    values = ["true"]
  }*/

}

# fetch id of the public subnet created in vpc.tf and use it to assign the ec2 instances created below
data "aws_subnet" "public_subnet_1" {
  id = aws_subnet.public-subnet-1.id
}

data "aws_subnet" "public_subnet_2" {
  id = aws_subnet.public-subnet-2.id
}



# Creating EC2 instances in Public Subnet
resource "aws_instance" "pub-instance" {
    for_each = var.instance_details
    ami                         = data.aws_ami.latest_amazon_linux.id
    instance_type               = each.value.instance_type
    key_name                    = var.keypair
    availability_zone           = each.value.availability_zone
    vpc_security_group_ids      = [aws_security_group.Web-sg.id]
    subnet_id                   = each.value.availability_zone == "us-east-1a" ? data.aws_subnet.public_subnet_1.id : data.aws_subnet.public_subnet_2.id
    associate_public_ip_address = true
    user_data                   = file("./app/data.sh")
    iam_instance_profile        = aws_iam_instance_profile.demo-profile.name
    tags = {
        Name = "My Public Instance"
    }
}
