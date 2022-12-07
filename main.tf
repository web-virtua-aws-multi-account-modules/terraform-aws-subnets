resource "aws_subnet" "create_subnets" {
  count                   = length(var.subnets)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnets[count.index].cidr_block
  map_public_ip_on_launch = var.subnets[count.index].map_public_ip_on_launch
  availability_zone       = var.subnets[count.index].availability_zone

  tags = merge(var.subnets[count.index].tags, {
    Name        = var.subnets[count.index].name
    "tf-subnet" = var.subnets[count.index].name
  })
}
