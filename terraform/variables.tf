variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
  default     = "vpc-0957f4d790aaaa5c5"
}

variable "subnet_id" {
  description = "Existing subnet ID"
  type        = string
  default     = "subnet-01a956362d02336ac"
}

variable "key_name" {
  description = "AWS EC2 key pair"
  type        = string
  default     = "stepup-HS001"
}

variable "ami_id" {
  description = "Ubuntu 24.04 AMI"
  type        = string
  default     = "ami-025d99823a4caad37"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "postgres-ha-aws-lab"
}
