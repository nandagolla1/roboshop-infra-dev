# output "azs" {
#   value = module.vpc.available_zones
# }

output "public_subnet_ids" {
  value = module.vpc.public_subnet_list
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_list
}

output "database_subnet_ids" {
  value = module.vpc.database_subnet_list
}