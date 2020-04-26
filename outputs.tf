output "aws_efs_file_system" {
  description = "EFS file system ID"
  value       = aws_efs_file_system.efs.id
}

output "this_iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = element(concat(aws_iam_user.users.*.arn, [""]), 0)
}

output "password" {
  description = "encrypted password of user"
  value       = "${aws_iam_user_login_profile.profile.encrypted_password}"
}

output "elb_dns_name" {
  description = "ELB name created: "
  value       = "${aws_elb.movies.dns_name}"
}

