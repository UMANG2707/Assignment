resource "aws_security_group" "mysql_sg" {
  name        = "mysql-security-group"
  description = "Allow SSH and MySQL access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.137.19.231/32"]
  }

  ingress {
    from_port   = 3307
    to_port     = 3307
    protocol    = "tcp"
    cidr_blocks = ["103.137.19.231/32"]
  }

  # Egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allows all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mysql_server" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.medium"
  key_name               = "testing-key"
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name
  associate_public_ip_address = true
  user_data = file("setup-sql.sh")
}

resource "aws_iam_role" "ssm_role" {
  name = "SSMRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ssm_managed_policy" {
  name       = "SSMPolicyAttachment"
  roles      = [aws_iam_role.ssm_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "SSMInstanceProfile"
  role = aws_iam_role.ssm_role.name
}
