data "aws_availability_zones" "available" {}

resource "aws_instance" "TF_instance" {
  ami                    = "ami-0ceecbb0f30a902a6"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_tf.id
  vpc_security_group_ids = [aws_security_group.vpc_tf_sg.id]
  key_name               = "tfkey"
  iam_instance_profile   = aws_iam_role.ec2_s3_tf_role.name
  tags = {
    Name = "TF_instance"
  }
  root_block_device {
    volume_size           = 15
    volume_type           = "gp2"
    delete_on_termination = true
  }

}
resource "aws_ebs_volume" "TF_ebs" {
  availability_zone = aws_subnet.public_subnet_tf.availability_zone
  size              = 12
  tags = {
    Name = "ebs_volume"
  }
}

resource "aws_volume_attachment" "TF_ebs_attachment" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.TF_ebs.id
  instance_id = aws_instance.TF_instance.id
}
