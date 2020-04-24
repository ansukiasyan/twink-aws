provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "html" {
  bucket        = "annas-twink-s3"
  force_destroy = true
  acl           = "private"

  lifecycle_rule {
    id      = "cleanup"
    enabled = true
    expiration {
      days = 7
    }

    noncurrent_version_expiration {
      days = 7
    }
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "html" {
  key    = "index.html"
  bucket = aws_s3_bucket.html.id
  source = "index.html"
  acl    = "private"
}


resource "aws_instance" "amazon_linux" {
  ami                    = "ami-0323c3dd2da7fb37d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.amazon_linux.id]

  user_data = <<-EOF
            #!/bin/bash
            sudo su
            yum update -y
            yum install httpd -y
            service httpd start
            chkconfig httpd on
            cd /var/www/html
            aws s3 cp s3://annas-twink-s3/index.html /var/www/html
            EOF

  tags = {
    Name = "web-server"
  }
  iam_instance_profile = aws_iam_instance_profile.s3_read.id
}


resource "aws_security_group" "amazon_linux" {
  name = "amazon_linux_instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "s3_read" {
  name               = "s3_read_only"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF    
}

resource "aws_iam_instance_profile" "s3_read" {
  name = "s3_read_only"
  role = aws_iam_role.s3_read.name
}


resource "aws_iam_role_policy" "s3_read" {
  name   = "s3_read_only_policy"
  role   = aws_iam_role.s3_read.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}