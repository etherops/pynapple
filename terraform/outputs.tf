output "pynapple1_load_balancer_dns_name" {
  value = module.pynapple1.load_balancer_dns_name
}

output "pynapple1_load_balancer_zone_id" {
  value = module.pynapple1.load_balancer_zone_id
}

output "pynapple1_rds_postgres_host" {
  value = module.pynapple1.rds_postgres_host
}

output "pynapple1_elasticache_redis_host" {
  value = module.pynapple1.elasticache_redis_host
}

output "pynapple1_ecr_repo_url" {
  value = module.pynapple1.ecr_repo_arn
}