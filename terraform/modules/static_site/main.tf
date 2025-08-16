provider "aws" {
  alias  = "us_east_1"
  region  = var.aws_region
  profile = "aws_terraform"
}
