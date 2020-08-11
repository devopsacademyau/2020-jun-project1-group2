resource "aws_efs_file_system" "efs_fs" {
  creation_token   = var.application_name
  encrypted        = true
  tags = {
    Name = var.application_name
  }
}

resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.efs_fs.id

  posix_user {
    uid = 1001
    gid = 1001
  }

  root_directory {
    path = "/${var.application_name}"

    creation_info {
      owner_uid   = 1001
      owner_gid   = 1001
      permissions = 755
    }
  }

  tags = {
    "Name" = var.application_name
  }
}

resource "aws_efs_mount_target" "efs_mount_target_pvt_a" {
  file_system_id  = aws_efs_file_system.efs_fs.id
  subnet_id       = module.vpc.pvt_sub_id_az_a
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "efs_mount_target_pvt_b" {
  file_system_id  = aws_efs_file_system.efs_fs.id
  subnet_id       = module.vpc.pvt_sub_id_az_b
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_file_system_policy" "efs_policy" {
  file_system_id = aws_efs_file_system.efs_fs.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "EFS_Policy",
    "Statement": [
        {
            "Sid": "ClientRootAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Resource": "${aws_efs_file_system.efs_fs.arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientRootAccess"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
POLICY
}
