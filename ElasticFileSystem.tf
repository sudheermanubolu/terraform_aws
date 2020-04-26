#Creation of EFS
resource "aws_efs_file_system" "efs" {
  throughput_mode  = "bursting"
  performance_mode = "generalPurpose"
  encrypted        = "false"
  tags = {
    Name = "cacheEFS"
  }
}

#Adding public subnets as targets.
resource "aws_efs_mount_target" "efs_mount_sub1" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.main-public-1.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs_mount_sub2" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.main-public-2.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "efs_mount_sub3" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.main-public-3.id
  security_groups = [aws_security_group.efs.id]
}



