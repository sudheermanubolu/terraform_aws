#Create Security group
resource "aws_security_group" "movies" {
  name        = "movies-sg"
  description = "Security group for movies EC2 instances"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = "Movies_SG"
  }
}

#Create ingress rule to allow SSH traffic
resource "aws_security_group_rule" "allow-ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.movies.id
  cidr_blocks       = ["0.0.0.0/0"]
}

#Create ingress rule to allow HTTP traffic
resource "aws_security_group_rule" "allow-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.movies.id
  cidr_blocks       = ["0.0.0.0/0"]
}

#Create egress rule to allow all traffic
resource "aws_security_group_rule" "egress_access" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.movies.id
}

#Instead of allowing AWS to create a random key, we pass the public key that we want to use.
resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = file("./terraform.pub")
}
