resource "aws_route53_zone" "primary" {
  name = "smanubolu.com"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.smanubolu.com"
  type    = "A"
  alias {
    name                   = aws_elb.movies.dns_name
    zone_id                = aws_elb.movies.zone_id
    evaluate_target_health = true
  }
}
