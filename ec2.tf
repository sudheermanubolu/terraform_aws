/* In this template, security groups will be created with necessary ingress and egress rules. 
Post that EC2 instances will be spinned off. */

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

# Creating E2 instances.
resource "aws_instance" "movies" {
  key_name               = aws_key_pair.terraform.key_name
  ami                    = "ami-05c81e9cd1a036235"
  instance_type          = "t2.micro"
  count                  = 2
  vpc_security_group_ids = [aws_security_group.movies.id]
  subnet_id              = aws_subnet.main-public-1.id
  tags = {
    Name = "usepb020101"
  }

  #once EC2 instance is created to make sure 
  connection {
    type        = "ssh"
    user        = "centos"
    private_key = file("~/.ssh/terraform")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"
  }

  # the below will create a profbob.passwd file which will have decrypted password and can be used to login to console.
  provisioner "local-exec" {
    command = "echo ${aws_iam_user.users.arn} > ${aws_iam_user.users.name}.passwd \n"
  }

  provisioner "local-exec" {
    command = "echo ${aws_iam_user_login_profile.profile.encrypted_password} |base64 -d|gpg -dq >> ${aws_iam_user.users.name}.passwd"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/install.sh",
      "sudo /tmp/install.sh"
    ]
  }
}
