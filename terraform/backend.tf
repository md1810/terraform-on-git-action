terraform{
    backend "s3" {
        bucket         = "github-terraform-statefile"
        key            = "some_environment/terraform.tfstate"
        dynamodb_table         = "terraform-locks"
        region                 = "eu-west-1"
        encrypt                = true
        skip_region_validation = true
    }
}
