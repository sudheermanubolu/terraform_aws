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

##creating ELB
resource "aws_elb" "movies" {
  name            = "terraform-asg-movies-elb"
  security_groups = [aws_security_group.elb.id]
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id, aws_subnet.main-public-3.id]
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/health.html"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

output "elb_dns_name" {
  value = "${aws_elb.movies.dns_name}"
}
