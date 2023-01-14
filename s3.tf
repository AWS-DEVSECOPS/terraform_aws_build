resource "aws_s3_bucket" "terraform-mystate-bucket-backup" {
  bucket = "terraform-mystate-bucket-backup"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform-mystate-bucket-backup.id
  versioning_configuration {
    status = "Enabled"
  }

}
resource "aws_s3_object" "mys3_files" {
  bucket = aws_s3_bucket.terraform-mystate-bucket-backup.id
  key    = "terraform/db.tf"
  source = "./db.tf"
}

resource "aws_s3_object" "mys3_files1" {
  bucket = aws_s3_bucket.terraform-mystate-bucket-backup.id
  key    = "terraform/db.tf"
  source = "./db.tf"
}

