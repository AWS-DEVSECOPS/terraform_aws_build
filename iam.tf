resource "aws_iam_role" "ec2_s3_tf_role" {
  name               = "ec2_s3_tf_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ec2_fullaccess" {
  name       = "ec2_fullaccess"
  roles      = [aws_iam_role.ec2_s3_tf_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "s3_fullaccess" {
  name       = "s3_fullaccess"
  roles      = [aws_iam_role.ec2_s3_tf_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "TF_instance_profile" {
  name = "ec2_s3_tf_role"
  role = aws_iam_role.ec2_s3_tf_role.name
}
