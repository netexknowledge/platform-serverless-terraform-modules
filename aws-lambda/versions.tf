terraform {
  required_version = ">= 1.0.4"

  required_providers {
    random = {
      source  = "random"
      version = ">= 3.6"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.63"
    }
  }
}
