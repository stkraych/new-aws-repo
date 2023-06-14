variable "region" {
  description = "Name of the region in aws provider"
  type        = string
  default     = "eu-west-1"
}
variable "availability_zones" {
  type = map(string)
  default = {
    zone_a = "eu-west-1a"
    zone_b = "eu-west-1b"
  }
}

variable "image_name" {
  default     = "amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"
  type        = string
  description = "Amazon linux image name"
}
variable "subnet_type" {
  type = map(string)
  default = {
    public  = "public"
    private = "private"
  }
}
variable "cidr_ranges" {
  type = map(string)
  default = {
    vpc      = "172.16.0.0/16"
    public1  = "172.16.1.0/24"
    public2  = "172.16.3.0/24"
    private1 = "172.16.4.0/24"
    private2 = "172.16.5.0/24"
  }
}

variable "personal_ip" {
  type    = string
  default = "0.0.0.0/0"

}

variable "ssm-policy" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
