# resource "aws_dynamodb_table" "terraform-lock" {
#     name           = "terraform-locks"
#     read_capacity  = 5
#     write_capacity = 5
#     hash_key       = "LockId"
#     attribute {
#         name = "LockId"
#         type = "S"
#     }
#     tags = {
#         "Name" = "DynamoDB Terraform State Lock Table"
#     }
# }
