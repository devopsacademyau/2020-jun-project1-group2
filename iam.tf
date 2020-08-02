resource "aws_iam_instance_profile" "ec2_efs_profile" {
  name = "ec2-efs-profile"
  role = aws_iam_role.ec2_efs_role.name
}

resource "aws_iam_role" "ec2_efs_role" {
  name = "ec2-efs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Name = "ecs-efs-role"
  }
}

resource "aws_iam_role_policy" "ecs_efs_policy" {
  name = "ecs-efs-policy"
  role = aws_iam_role.ec2_efs_role.id

  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite",
                "elasticfilesystem:ClientRootAccess"
            ],
            "Resource": "arn:aws:elasticfilesystem:${var.region}:${var.aws_acct_number}:file-system/${aws_efs_file_system.efs_fs.id}",
            "Condition": {
                "StringEquals": {
                    "elasticfilesystem:AccessPointArn": "arn:aws:elasticfilesystem:${var.region}:${var.aws_acct_number}:access-point/${aws_efs_access_point.efs_access_point.id}"
                }
            }
        }
    ]
}
  EOF
}