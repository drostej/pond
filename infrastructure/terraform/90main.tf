terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  profile = "tefde-sandbox"
}

provider "random" {}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-pond-two"
}

resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "state_lock_table" {
  name         = "terraform_state_lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_eip" "lb" {
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = var.subnet_id_eur_cent_1

  tags = {
    Name = "nat-pond-gateway"
  }

}

