resource "aws_security_group" "allow_ssh" {
  name        = "${local.env_name}${" dev ssh access"}"
  description = "Allow developer SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.ip_addresses_devs
  }
}

resource "aws_security_group" "pynapple_alb_to_asg" {
  name        = "${local.env_app_name}${" alb to asg"}"
  description = "Allow HTTP Traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }
}