variable "aws_region" { description = "AWS region" type = string default = "ap-south-1" }
variable "project_name" { description = "Resource prefix" type = string default = "clothing-platform" }
variable "environment" { description = "Environment" type = string default = "dev" validation { condition = contains(["dev","qa","prod"], var.environment) error_message = "Use dev, qa, or prod." } }
