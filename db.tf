resource "aws_dynamodb_table" "dynamodb_state_locking" {
  name           = "dynamodb-state-locking"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5
  attribute {
    name = "LockID"
    type = "S"
  }
}
