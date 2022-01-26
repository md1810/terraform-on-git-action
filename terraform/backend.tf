terraform{
    backend "s3" {
        bucket         = "github-terraform-statefile"
        key            = "some_environment/terraform.tfstate"
        dynamodb_table         = "terraform-locks"
        region                 = var.aws_region
        encrypt                = true
        skip_region_validation = true
    }
}
