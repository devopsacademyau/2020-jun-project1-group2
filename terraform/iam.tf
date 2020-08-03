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
    Name = "ec2-efs-role"
  }
}

resource "aws_iam_role_policy" "ec2_efs_policy" {
  name = "ec2-efs-policy"
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
            "Resource": "arn:aws:elasticfilesystem:${var.region}:${local.account_id}:file-system/${aws_efs_file_system.efs_fs.id}",
            "Condition": {
                "StringEquals": {
                    "elasticfilesystem:AccessPointArn": "arn:aws:elasticfilesystem:${var.region}:${local.account_id}:access-point/${aws_efs_access_point.efs_access_point.id}"
                }
            }
        }
    ]
}
  EOF
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"

  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    Name = "ecs-task-role"
  }
}

resource "aws_iam_role_policy" "ecs_task_policy" {
  name = "ecs-task-policy"
  role = aws_iam_role.ecs_task_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "*"
      },
      {
        "Sid": "EFSPolicy",
        "Effect": "Allow",
        "Action": [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess"
        ],
        "Resource": "arn:aws:elasticfilesystem:${var.region}:${local.account_id}:file-system/${aws_efs_file_system.efs_fs.id}",
        "Condition": {
          "StringEquals": {
            "elasticfilesystem:AccessPointArn": "arn:aws:elasticfilesystem:${var.region}:${local.account_id}:access-point/${aws_efs_access_point.efs_access_point.id}"
          }
        }
      }
   ]
  }
  EOF
}