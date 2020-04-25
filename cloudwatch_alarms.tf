resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "terraform-cpu-alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "ec2 cpu utilization monitor"
  alarm_actions       = [aws_sns_topic.alerts.arn]
}
