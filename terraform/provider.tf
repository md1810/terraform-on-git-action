
# provider.tf

provider "aws" {
    region = var.aws_region
    allowed_account_ids = var.account_ids
    default_tags {
      tags = {
          App = var.app_name,
          Stage = var.stage_name
      }
    }
}
