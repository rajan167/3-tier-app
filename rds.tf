# Creating RDS Instance
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.database-subnet-1.id,aws_subnet.database-subnet-2.id]
tags = {
  Name = "My DB subnet group"
}
}
resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.id
  engine                 = "mysql"
  instance_class         = "db.t2.small"
  db_name                = "mydb"
  multi_az               = true
  username               = "username"
  password               = random_password.password.result
  #password              = aws_secretsmanager_secret_version.example_secret_version.secret_string
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}

resource "random_password" "password" {
  length           = 16
}
/* Uncomment the code if you want to store your password in secrets manager in AWS
resource "aws_secretsmanager_secret" "secretmasterDB" {
   name = "Masteraccoundb"
}

resource "aws_secretsmanager_secret_version" "example_secret_version" {
  secret_id     = aws_secretsmanager_secret.secretmasterDB.id
  secret_string = jsonencode({
    password = random_password.password.result
  })
} */