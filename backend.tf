terraform {
  backend "s3" {
    encrypt = true
    skip_region_validation = true
  }
}
