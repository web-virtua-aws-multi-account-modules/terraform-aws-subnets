variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "Define the subnets configuration"
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool)
    tags                    = optional(map(any))
  }))
}
