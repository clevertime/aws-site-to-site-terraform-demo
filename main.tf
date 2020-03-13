###############
# Locals
###############

# Get AWS account ID
data "aws_caller_identity" "current" {}

# Get current region
data "aws_region" "current" {}

# AZs
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  region     = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
}

################################
# Step 3: VPCs and EC2 Key Pair
################################

module "vpc-a" {
  source   = "./modules/vpc"
  vpc_name = join("-",[var.prefix,"a"])
  octet    = "88"
  region   = local.region

}
module "vpc-b" {
  source   = "./modules/vpc"
  vpc_name = join("-",[var.prefix,"b"])
  octet    = "98"
  region   = local.region
}

# EC2 Key Pair
resource "aws_key_pair" "this" {
  key_name_prefix = var.prefix
  public_key      = var.public_key
}
