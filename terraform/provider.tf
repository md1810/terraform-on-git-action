
# provider.tf

provider "aws" {
  version = "~> 3.5.0"
  profile = "default"
  region = var.aws_region
}
