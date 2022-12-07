# AWS subnets for multiples accounts and regions with Terraform module
* This module simplifies creating and configuring of the subnets across multiple accounts and regions on AWS

* Is possible use this module with one region using the standard profile or multi account and regions using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Create file versions.tf with the exemple code below:
```hcl
terraform {
  required_version = ">= 1.1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
```

* Criate file provider.tf with the exemple code below:
```hcl
provider "aws" {
  alias   = "alias_profile_a"
  region  = "us-east-1"
  profile = "my-profile"
}

provider "aws" {
  alias   = "alias_profile_b"
  region  = "us-east-2"
  profile = "my-profile"
}
```


## Features enable of subnets configurations for this module:

- Subnets

## Usage exemples


### Create subnets from configuration list

```hcl
module "vpc_main" {
  source  = "web-virtua-aws-multi-account-modules/subnets/aws"
  vpc_id  = "vpc-0e4dcb...88362"
  subnets = var.subnets

  providers = {
    aws = aws.alias_profile_b
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| vpc_id | `string` | `-` | yes | VPC ID | `-` |
| subnets | `list(object)` | `-` | yes | Define the subnets configuration| `-` |

* Model of variable subnets
```hcl
variable "subnets" {
  description = "Define the subnets configuration"
  type = list(object({
    name                    = string
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool)
    tags                    = optional(map(any))
  }))
  default = [
    {
      name                    = "tf-private-subnet-a"
      cidr_block              = "10.0.10.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
      tags                    = {}
    },
    {
      name              = "tf-private-subnet-b"
      cidr_block        = "10.0.11.0/24"
      availability_zone = "us-east-1b"
    },
  ]
}
```

## Resources

| Name | Type |
|------|------|
| [aws_subnet.create_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `subnets` | All informations of the subnets |
