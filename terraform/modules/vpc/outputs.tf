
output "vpc_id" {
  value = "${aws_vpc.ecs-vpc.id}"
}

# ECS network configuration needs these.
output "ecs_private_subnet_ids" {
  value = ["${aws_subnet.ecs-private-subnet.*.id}"]
}

output "alb_public_subnet_ids" {
  value = ["${aws_subnet.alb-public-subnet.*.id}"]
}

output "nat_public_subnet_id" {
  value = "${aws_subnet.nat-public-subnet.id}"
}


output "internet_gateway_id" {
  value = ["${aws_internet_gateway.internet-gateway.id}"]
}

data "aws_subnet_ids" "output-ecs-private-subnet-ids" {
  vpc_id = "${aws_vpc.ecs-vpc.id}"
}

data "aws_subnet" "output-ecs-private-subnet" {
  count = "${var.private_subnet_count}"
  id    = "${data.aws_subnet_ids.output-ecs-private-subnet-ids.ids[count.index]}"
}

output "ecs_subnet_cidr_blocks" {
  value = ["${data.aws_subnet.output-ecs-private-subnet.*.cidr_block}"]
}

# ECS needs to know the availability zone names used for ECS cluster.
output "ecs_subnet_availability_zones" {
  value = ["${data.aws_subnet.output-ecs-private-subnet.*.availability_zone}"]
}


output "alb-public-subnet-sg_id" {
  value = "${aws_security_group.alb-public-subnet-sg.id}"
}

output "ecs_private_subnet_sg_id" {
  value = "${aws_security_group.ecs-private-subnet-sg.id}"
}

output "nat_public_subnet_sg_id" {
  value = "${aws_security_group.nat-public-subnet-sg.id}"
}

