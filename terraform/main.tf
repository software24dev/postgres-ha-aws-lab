locals {
  servers = {
    dcs-1 = {
      instance_type = "t3.micro"
      role          = "etcd"
    }
    dcs-2 = {
      instance_type = "t3.micro"
      role          = "etcd"
    }
    dcs-3 = {
      instance_type = "t3.micro"
      role          = "etcd"
    }
    pg-ha-1 = {
      instance_type = "t3.small"
      role          = "postgres"
    }
    pg-ha-2 = {
      instance_type = "t3.small"
      role          = "postgres"
    }
    pg-ha-3 = {
      instance_type = "t3.small"
      role          = "postgres"
    }
    db-router-1 = {
      instance_type = "t3.micro"
      role          = "haproxy"
    }
    mattermost-1 = {
      instance_type = "t3.small"
      role          = "mattermost"
    }
  }
}

resource "aws_instance" "ha" {
  for_each = local.servers

  ami                    = data.aws_ssm_parameter.al2023_ami.value
  instance_type          = each.value.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ha.id]

  associate_public_ip_address = true

  tags = {
    Name    = "suta-HS001-${each.key}"
    Project = var.project_name
    Role    = each.value.role
  }
}
