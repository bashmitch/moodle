terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "~> 5.17.0"
    }
  }
}

provider "google" {
  project     = "wordpress-400315"
  region      = "us-central1"
  credentials = "./gcp.key.json"
}

provider "aws" {
  region     = "us-east-1" # Change to your desired AWS region
  access_key = "AKIA5MPGBGUGVHYBSSX2"
  secret_key = "NPoHPiGlVqqOrf+crm0l+i6n/ggsP+XKZiwJZ+fc"
}

