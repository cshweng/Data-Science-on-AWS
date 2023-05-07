provider "aws" {
  region = "ap-east-1"
}

resource "aws_instance" "airflow" {
  ami           = "ami-0d7ce860e738db09b"
  instance_type = "t3.large"
  key_name      = "Airflow"
  vpc_security_group_ids = [aws_security_group.mongodb_sg.id]
  tags = {
    Name = "Airflow-instance"
  }

  user_data = file("bootstrap.sh")
}

resource "aws_security_group" "mongodb_sg" {
  name        = "airflow_sg"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port = 8080
    to_port   = 8080
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
  value = aws_instance.airflow.public_ip
}