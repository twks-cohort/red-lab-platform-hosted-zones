terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twks-cohort"
    workspaces {
      prefix = "red-lab-platform-hosted-zones-"
    }
  }
}
