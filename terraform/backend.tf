terraform{
    backend "s3" {
        bucket         = "github-terraform-statefile"
        key            = "some_environment/terraform.tfstate"
        dynamodb_table         = "duve-locks"
        encrypt                = true
        skip_region_validation = true
    }
}
