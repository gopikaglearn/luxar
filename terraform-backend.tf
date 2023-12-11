terraform {
  backend "s3" {
    bucket = "git-glearns-online-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
