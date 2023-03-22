data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = [true]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

resource "aws_default_vpc" "default" {
  tags = merge(
    var.tags,
    { Name = "Default VPC" }
  )
}

resource "aws_default_subnet" "default" {
  for_each = data.aws_subnet.default

  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    { Name = "Default Subnet" }
  )
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_default_vpc.default.default_route_table_id

  tags = merge(
    var.tags,
    { Name = "Default Route Table" }
  )
}

# Ignore "subnet_ids" changes to avoid the known issue below.
# https://github.com/hashicorp/terraform/issues/9824
# https://github.com/terraform-providers/terraform-provider-aws/issues/346
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_default_vpc.default.default_network_acl_id

  tags = merge(
    var.tags,
    { Name = "Default Network ACL" }
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  tags = merge(
    var.tags,
    { Name = "Default Security Group" }
  )
}