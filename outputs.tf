output "dev-vpc-id" {
  value = resource.aws_vpc.waiphyo_dev_vpc.id
}

output "pub-subent-id" {
  value = resource.aws_subnet.public_subnet.id
}

output "private-subnet-id" {
  value = resource.aws_subnet.private_subnet.id
  
}
output "dev-igw-id" {
  value = resource.aws_internet_gateway.waiphyo_dev.id
  
}

output "elastic_ip" {
  value = resource.aws_eip.elastic_ip.address
  
}

output "nat_id" {
  value = resource.aws_nat_gateway.waiphyo_dev.id
  
}
