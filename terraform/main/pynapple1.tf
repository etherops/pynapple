module "pynapple1" {
  source = "../module-sandbox_service"
  count  = var.enable_resources ? 1 : 0

  # on/off
  enable_resources = var.enable_resources
  instance_count   = var.instance_count

  # app
  env_name = local.env_name
  app_name = "pynapple1"

  # networking
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr_block             = module.vpc.vpc_cidr_block
  public_subnets             = module.vpc.public_subnets
  private_subnets            = module.vpc.private_subnets
  database_subnets           = module.vpc.database_subnets
  key_pair_name              = var.key_pair_name
  ip_addresses_devs          = var.developer_ip_cidrs
  eks_node_security_group_id = module.eks[0].node_security_group_id
  security_group_ids = [
    aws_security_group.allow_ssh.id,
    module.vpc.default_security_group_id
  ]

  # components
  app_db_name        = "pynapple"
  database_engine    = "postgres"
  cache_engine       = "redis"

  # runtime env vars
  common_env_vars = [
    {
      name  = "FLASK_ENV"
      value = "development"
    }
  ]
  k8s_env_vars = [
    {
      name  = "DOWNSTREAM_PYNAPPLE_HOST"
      value = "pynapple2.default.svc.cluster.local"
    }
  ]
  ec2_env_vars = [
    {
      name  = "DOWNSTREAM_PYNAPPLE_HOST"
      value = module.pynapple2[0].load_balancer_dns_name
    }
  ]

  # tags
  common_tags = local.common_tags
}