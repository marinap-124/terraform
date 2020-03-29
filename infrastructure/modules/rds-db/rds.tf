resource "aws_db_instance" "rds_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.22"
  instance_class       = "db.t2.micro"
  name                 = "db_appointment"
  username             = "root"
  password             = "kex12456"
  parameter_group_name = "default.mysql5.7"
  max_allocated_storage = 15
  storage_encrypted    = false
  deletion_protection  = false
  iam_database_authentication_enabled = false
  final_snapshot_identifier = "rds-backup"
  
  # Don't copy this to your production examples. It's only here to make it quicker to delete this DB.
  skip_final_snapshot = true
  
}

 