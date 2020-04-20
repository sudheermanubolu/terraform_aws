
resource "aws_launch_configuration" "movies_web" {
  image_id        = "ami-001a5854c8627a5b7"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.movies.id]
  key_name        = aws_key_pair.terraform.key_name
}

resource "aws_autoscaling_group" "movies_asg" {
  launch_configuration = aws_launch_configuration.movies_web.id
  vpc_zone_identifier  = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-public-3.id]
  load_balancers       = [aws_elb.movies.name]
  min_size             = 2
  max_size             = 10
  tags = [{
    key                 = "Name"
    value               = "terraform-asg-movies"
    propagate_at_launch = true
  }]
}
