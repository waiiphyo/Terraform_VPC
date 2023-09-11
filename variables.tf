variable "dev_vpc_cidr" {
    default = "192.168.0.0/16"
}

variable "vpc_name" {
    default = "waiphyo-dev-vpc"
}

variable "public_subnet" {
    default = "192.168.10.0/24"
  
}

variable "az" {
  default = "us-east-1a"
}

variable "public_subent_name" {
    default = "waiphyo-dev-public"
}

variable "igw_name" {
    default = "waiphyo-dev"
  
}

variable "pub_route" {
  default = "public-route"
}

variable "private_cidr" {
  default = "192.168.50.0/24"
}

variable "private_subent_name" {
  default = "waiphyo-dev-private"
}

variable "nat_name" {
  default = "waiphyo-dev"
}

variable "nat_route_table_name" {
  default = "private-route"
}