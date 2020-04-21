
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
