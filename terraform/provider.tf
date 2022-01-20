
# provider.tf
required_version = "~> 0.12.29"
# Specify the provider and access details
provider "aws" {
  #shared_credentials_file = "$HOME/.aws/credentials"
  profile = "default"
  version = "~> 3.0"
  region  = var.aws_region
}
