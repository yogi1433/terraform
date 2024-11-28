# Generate Private Key
resource "tls_private_key" "secure" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create Key Pair in AWS
resource "aws_key_pair" "secure_key" {
  key_name   = "secure-key"
  public_key = tls_private_key.secure.public_key_openssh
}



