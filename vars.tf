variable "region" {
    description = "AWS Region"
    type        = string
    default     = "us-east-2"
}
 
variable "main_vpc_cidr" {
    description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
    type        = string
    default     = "0.0.0.0/0"
}

variable "public_subnets_1" {
    description = "Suffix to append to public subnets name"
    type        = string
    default     = "public"
}

variable "public_subnets_2" {
    description = "Suffix to append to public subnets name"
    type        = string
    default     = "public"
}

variable "private_subnets_1" {
    description = "Suffix to append to private subnets name"
    type        = string
    default     = "private"
}

variable "private_subnets_2" {
    description = "Suffix to append to private subnets name"
    type        = string
    default     = "private"
}

variable "name_prefix" {
    description = "Suffix to append to all objects"
    type        = string
    default     = "blockaid"
}