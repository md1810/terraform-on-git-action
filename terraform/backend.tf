backend "s3" {
    bucket         = "github-terraform-statefile"
    key            = "some_environment/terraform.tfstate"
}
