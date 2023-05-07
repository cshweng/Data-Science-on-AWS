provider "aws" {
  region = "ap-east-1"
}

resource "aws_instance" "mongodb" {
  ami           = "ami-0d7ce860e738db09b"
  instance_type = "t3.micro"
  key_name      = "MongoDB"
  vpc_security_group_ids = [aws_security_group.mongodb_sg.id]
  tags = {
    Name = "Mongodb-instance"
  }

  user_data = file("bootstrap.sh")
}

resource "aws_security_group" "mongodb_sg" {
  name        = "mongodb_sg"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.mongodb.public_ip
}
