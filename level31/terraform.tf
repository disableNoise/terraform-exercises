terraform {
  cloud {
    organization = "Learning_Terraform_celgueda"

    workspaces {
      project = "Learn Terraform Level 31"
      name    = "learn-terraform-level-31"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.00"
    }
  }

  required_version = ">= 1.2"
}
