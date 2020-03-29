provider "aws" {
  region                  = var.region
  shared_credentials_file = "/home/marinap/.aws/credentials"
  profile                 = "marinap_terraform" 
  version                 = "~> 2.52"
}


module "rds-db" {
  source                = "./modules/rds-db"
}

module "pipeline" {
  source                = "./modules/pipeline"
} 