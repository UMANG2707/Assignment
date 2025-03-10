resource "aws_security_group" "mysql_sg" {
  name        = "mysql-security-group"
  description = "Allow SSH and MySQL access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["IP/32"]
  }

  ingress {
    from_port   = 3307
    to_port     = 3307
    protocol    = "tcp"
    cidr_blocks = ["IP/32"]
  }
}

resource "aws_instance" "mysql_server" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID (change as needed)
  instance_type = "t2.micro"
  key_name      = "test"
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
  user_data = file("install_mysql.sh")
}
