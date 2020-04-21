####################################
##Security Group for EC2 instances##
####################################

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

####################################
######Security Group for MySQL######
####################################

##security group for MySQL to allow port 3306 ingress and all egress traffic
resource "aws_security_group" "rds" {
  name        = "rds-sg"
  vpc_id      = aws_vpc.main.id
  description = "Security group for MySQL"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

####################################
#######Security Group for ELB#######
####################################

##security group for ELB to allow port 80 ingress and all egress traffic
resource "aws_security_group" "elb" {
  name        = "elb-sg"
  vpc_id      = aws_vpc.main.id
  description = "Security group for movies ELB"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
