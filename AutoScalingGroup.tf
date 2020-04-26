
#Instead of allowing AWS to create a random key, we pass the public key that we want to use.
resource "aws_key_pair" "terraform" {
  key_name   = "terraform"
  public_key = file("./terraform.pub")
}

#Launch config that will be applied to EC2 instances when they get created.
resource "aws_launch_configuration" "movies_web" {
  image_id        = "ami-0f26a052a49d63163"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.movies.id]
  key_name        = aws_key_pair.terraform.key_name
}

# ASG creation for movies ELB.
resource "aws_autoscaling_group" "movies_asg" {
  launch_configuration      = aws_launch_configuration.movies_web.id
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-public-3.id]
  load_balancers            = [aws_elb.movies.name]
  min_size                  = 2
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "ELB"
  tags = [{
    key                 = "Name"
    value               = "terraform-asg-movies"
    propagate_at_launch = true
  }]
}
