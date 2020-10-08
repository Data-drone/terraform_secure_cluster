resource "aws_iam_role" "sec_clus_ec2_role" {
  name = "sec_clus_ec2_role"

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
      owner = var.acc_owner
  }
}

resource "aws_iam_instance_profile" "sec_clus_profile" {
  name = "sec_clus_profile"
  role = aws_iam_role.sec_clus_ec2_role.name
}

resource "aws_iam_role_policy" "secclus_policy" {
  name = "secclus_policy"
  role = aws_iam_role.sec_clus_ec2_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}