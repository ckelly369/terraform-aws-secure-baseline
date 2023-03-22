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

provider "aws" {
  region = "eu-west-2"
}

module "secure_baseline_eu_west_1" {
  source = "../../modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-1
   }
}

# module "secure_baseline_eu_west_2" {
#   source = "../../modules/vpc-baseline"

#   providers = {
#     aws = aws.eu-west-2
#    }
# }

# module "secure_baseline_us_west_1" {
#   source = "../../modules/vpc-baseline"

#   providers = {
#     aws = aws.us-west-1
#    }
# }

# module "secure_baseline_us_west_2" {
#   source = "../../modules/vpc-baseline"

#   providers = {
#     aws = aws.us-west-2
#    }
# }