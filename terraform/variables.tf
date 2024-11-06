variable "region" {
  description = "AWS region where resources will be deployed. Set the default region to deploy resources if not specified."
  type        = string
  default     = "<specify default AWS region here>"
}

variable "vpc_name" {
  description = "Specify the name of the VPC to be selected"
  type        = string
  default     = "<specify default VPC name here>"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "<specify default instance type here>"
}

variable "volume_type" {
  description = "Volume type for the EC2 instance"
  type        = string
  default     = "<specify default volume type for the instance here>"
}

variable "volume_size" {
  description = "Volume size in GB for the EC2 instance"
  type        = string
  default     = <specify the size of volume for the instance here>
}

variable "ami" {
  description = "The ID of the Amazon Machine Image (AMI) to use for the instance"
  type        = string
  default     = "<specify default AMI for the instance here>"
}

variable "key_name" {
  description = "The name of the SSH key to access the instance"
  type        = string
  default     = "<specify default SSH key to alow access to the instance here>"
}

variable "instance_name" {
  description = "The name of the EC2 instance to be used as a Name tag"
  type        = string
  default     = "<specify default name to the instance here>"
}

variable "security_group_ids" {
  description = "List of Security Group IDs to associate with the EC2 instance"
  type        = list(string)
  default = ["<specify default Security Group IDs to the instance here>
  ]
}
