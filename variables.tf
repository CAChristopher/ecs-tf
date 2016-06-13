variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "ami" {
  description = "AMI id to launch, must be in the region specified by the region variable"
  default = {
    "us-west-2" = "ami-32a85152"
  }
}

variable "availability_zones" {
  description = "Comma separated list of EC2 availability zones to launch instances, must be within region"
  default = {
    "us-west-2" = "us-west-2a,us-west-2b"
  }
}

variable "subnet_ids" {
  description = "Comma separated list of subnet ids, must match availability zones"
  default = {
    "us-west-2" = ""
  }
}

variable "security_group_ids" {
  description = "Comma separated list of security group ids"
  default = {
    "us-west-2" = ""
  }
}

variable "instance_type" {
  default = "m3.large"
  description = "Name of the AWS instance type"
}

variable "min_size" {
  default = "2"
  description = "Minimum number of instances to run in the group"
}

variable "max_size" {
  default = "2"
  description = "Maximum number of instances to run in the group"
}

variable "desired_capacity" {
  default = "2"
  description = "Desired number of instances to run in the group"
}

variable "health_check_grace_period" {
  default = "300"
  description = "Time after instance comes into service before checking health"
}

variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
  default = {
    "us-west-2" = ""
  }
}

variable "root_size" {
  description = "root volume size"
  default = "200"
}

variable "ecs_role_arn" {
  description = "arn for aws ecs policy"
  default = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

variable "s3_role_arn" {
  description = "arn for aws s3 policy"
  default = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}