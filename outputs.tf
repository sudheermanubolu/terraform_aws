output "aws_efs_file_system" {
  description = "EFS file system ID"
  value       = aws_efs_file_system.efs.id
}

output "this_iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = element(concat(aws_iam_user.users.*.arn, [""]), 0)
}

output "elb_dns_name" {
  description = "ELB name created: "
  value       = "${aws_elb.movies.dns_name}"
}

