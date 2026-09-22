resource "aws_security_group" "ha" {
  name        = "${var.project_name}-sg"
  description = "Security group for PostgreSQL HA lab"
  vpc_id      = var.vpc_id

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ha.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "SSH"
}

resource "aws_vpc_security_group_ingress_rule" "postgresql" {
  security_group_id            = aws_security_group.ha.id
  referenced_security_group_id = aws_security_group.ha.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "PostgreSQL"
}

resource "aws_vpc_security_group_ingress_rule" "etcd_client" {
  security_group_id            = aws_security_group.ha.id
  referenced_security_group_id = aws_security_group.ha.id
  from_port                    = 2379
  to_port                      = 2379
  ip_protocol                  = "tcp"
  description                  = "etcd client"
}

resource "aws_vpc_security_group_ingress_rule" "etcd_peer" {
  security_group_id            = aws_security_group.ha.id
  referenced_security_group_id = aws_security_group.ha.id
  from_port                    = 2380
  to_port                      = 2380
  ip_protocol                  = "tcp"
  description                  = "etcd peer"
}

resource "aws_vpc_security_group_ingress_rule" "patroni" {
  security_group_id            = aws_security_group.ha.id
  referenced_security_group_id = aws_security_group.ha.id
  from_port                    = 8008
  to_port                      = 8008
  ip_protocol                  = "tcp"
  description                  = "Patroni REST API"
}

resource "aws_vpc_security_group_ingress_rule" "haproxy_stats" {
  security_group_id            = aws_security_group.ha.id
  referenced_security_group_id = aws_security_group.ha.id
  from_port                    = 5000
  to_port                      = 5000
  ip_protocol                  = "tcp"
  description                  = "HAProxy stats"
}

resource "aws_vpc_security_group_ingress_rule" "mattermost" {
  security_group_id = aws_security_group.ha.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8065
  to_port           = 8065
  ip_protocol       = "tcp"
  description       = "Mattermost"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.ha.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow outbound traffic"
}
