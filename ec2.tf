provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.secure_key.key_name # Reference key pair
  subnet_id = aws_subnet.public.id

  # Use vpc_security_group_ids for security group IDs
  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]


  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install -y nginx
                systemctl start nginx
                systemctl enable nginx
                EOF

  tags = {
    Name = "nginx-instance"
  }
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.nginx.public_ip
}
