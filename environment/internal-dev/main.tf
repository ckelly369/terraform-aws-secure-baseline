terraform {
  backend "s3" {
    bucket = "ckelly-terraform-backend1"
    key    = "internal-dev/terraform.tfstate"
    region = "eu-west-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.20"
    }
  }
}

module "vpc_baseline_eu_west_1" {
  source = "../../modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-1
    # aws = aws.eu-west-2
   }
}

module "ebs_baseline_eu_west_1" {
  source = "../../modules/ebs-baseline"

  providers = {
    aws = aws.eu-west-1
   }
}