variable "ami_id" {
  type        = string
  description = "ami id of the instance"
}
variable "instance_type" {
  type        = string
  description = "type of isntance"
}
variable "project_name" {
  type        = string
  description = "name of the project"
}
variable "project_env" {
  type        = string
  description = "Environment of the project"
}
variable "project_own" {
  type        = string
  description = "Owner of the project"
}
variable "region" {
  type        = string
  description = "project-region"
}
variable "hosted_zone_name" {
  type        = string
  description = "Domain name"
}
variable "hostname" {
  type = string
}
variable "hosted_zone_id" {
  type        = string
  description = "Zone of the domain"
}
