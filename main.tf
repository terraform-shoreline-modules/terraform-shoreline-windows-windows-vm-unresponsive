terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "unresponsive_windows_ec2_instance_on_aws_with_rdp_connection_issue" {
  source    = "./modules/unresponsive_windows_ec2_instance_on_aws_with_rdp_connection_issue"

  providers = {
    shoreline = shoreline
  }
}