resource "aws_sns_topic" "alerts" {
  name = "alerts-topic"

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  provisioner "local-exec" {
    command = "aws sns subscribe --region us-east-1 --topic-arn ${self.arn} --protocol email --notification-endpoint sudheer_manubolu@student.uml.edu"
  }
  provisioner "local-exec" {
    command = "aws sns subscribe --region us-east-1 --topic-arn ${self.arn} --protocol sms --notification-endpoint +16022078631"
  }
}
