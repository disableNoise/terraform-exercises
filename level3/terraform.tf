terraform {
  cloud {
    organization = "Learning_Terraform_celgueda"

    workspaces {
      project = "Learn Terraform Level 3"
      name    = "learn-terraform-level-3"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  required_version = ">= 1.2"
}
