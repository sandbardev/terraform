terraform {
  backend "s3" {
    bucket       = "terraform-state-985539768306-sa-east-1-an"
    key          = "dev/terraform.tfstate"
    region       = "sa-east-1"
    use_lockfile = true
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.15"
}
