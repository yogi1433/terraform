# Create Security Group
resource "aws_security_group" "web_sg" {
  name        = "secure-security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.secure.id # Reference the VPC where the security group will be created

  # Ingress Rule: Allow SSH from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change to your IP if restricting access
  }

  # Ingress Rule: Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress Rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}