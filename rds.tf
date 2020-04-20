##security group for ELB to allow port 80 ingress and all egress traffic
resource "aws_security_group" "rds" {
  name        = "rds-sg"
  vpc_id      = aws_vpc.main.id
  description = "Security group for MySQL"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_subnet_group" "rds" {
  name        = "rds"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id, aws_subnet.main-private-3.id]
}
resource "aws_db_instance" "movies-rds" {
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "5.7.28"
  instance_class         = "db.t2.micro"
  identifier             = "mymovies-rds"
  name                   = "members"
  username               = "admin"
  password               = "admin123"
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  parameter_group_name   = "default.mysql5.7"
  multi_az               = "false"
  vpc_security_group_ids = [aws_security_group.rds.id]
  storage_type           = "gp2"
  skip_final_snapshot    = "true"

  backup_retention_period = 30
  tags = {
    Name = "movies-rds"
  }

}

/*
CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
*/
