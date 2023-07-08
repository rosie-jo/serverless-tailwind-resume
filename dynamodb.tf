resource "aws_dynamodb_table" "dynamodb-table" {
  name         = "${random_string.random_suffix.result}-terra_visitor_Counter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "countID"

  attribute {
    name = "countID"
    type = "S"
  }

  tags = {
    Name        = "cldRsmChllng"
    Environment = "dev"
  }
}

resource "aws_dynamodb_table_item" "initial_items" {
  table_name = aws_dynamodb_table.dynamodb-table.name
  hash_key   = aws_dynamodb_table.dynamodb-table.hash_key

  item = <<ITEM
  {
    "countID": {"S": "1"},
    "count": {"N": "0"}
  }
  ITEM
}