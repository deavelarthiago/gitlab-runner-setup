data "aws_vpc" "selected" {
  tags = {
    Name = "var.vpc_name"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Tier"
    values = ["Private"]
  }
}
