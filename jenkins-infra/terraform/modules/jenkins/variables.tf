variable "ami_id" {
  description = "AMI ID for the Jenkins server"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Jenkins server"
  type        = string
  default     = "t2.medium"
}

variable "vpc_id" {
  description = "The ID of the VPC where the Jenkins server will be deployed"
  type        = string
}
