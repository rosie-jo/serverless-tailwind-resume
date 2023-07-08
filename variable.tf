# route 53 variables 
variable "domain" {
  default     = "rosie-jo.com"
  description = "domain name"
  type        = string
}

variable "sub_domain" {
  default     = "www.rosie-jo.com"
  description = "subdomain name"
  type        = string
}

variable "myregion" {
  default = "us-east-1"
}

variable "accountId" {
  default = "171544473715"
}
