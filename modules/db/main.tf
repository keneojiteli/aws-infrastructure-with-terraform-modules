# provides an RDS DB subnet group resource (private subnet), a single resource that can take multiple subnets
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.subnet_grp_name
  count =  length(var.priv_subnet)
  subnet_ids = var.priv_subnet[*] # child/child dependency

  tags = {
    Name = var.subnet_grp_name
  }
}

# provides an RDS instance resource
resource "aws_db_instance" "my_db" {
  count = length(var.priv_subnet)
  identifier              = var.id
  engine                  = var.db_engine
  engine_version          = var.db_eng_version
  instance_class          = var.instance_class
  allocated_storage       = var.storage
  storage_type            = "gp2"
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group[count.index].name
  vpc_security_group_ids  = var.sg # child/child dependency
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  skip_final_snapshot     = true
  publicly_accessible     = false #keeps the RDS instance private and can be reached bu ecs task, db resides in private subnet

  tags = {
    Name = "rds_db"
  }
}