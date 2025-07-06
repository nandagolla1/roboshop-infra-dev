module "vpc" {
  source = "git::https://github.com/nandagolla1/terraform-aws-vpc.git?ref=main"
  project = var.project
  environment = var.environment
  public_subnet_cidr_block_ids = var.public_subnet_list
  private_subnet_cidr_block_ids = var.private_subnet_list
  database_subnet_cidr_block_ids = var.database_subnet_list
  is_peering_required = true
}