variable "region" {
  description = "region of the instance"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "type of the instance"
  type        = string
  default     = "t3.micro"
}
