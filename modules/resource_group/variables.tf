#####################################################
# Resouce Group Options
# https://www.terraform.io/docs/providers/azurerm/r/resource_group.html
#####################################################
variable "resourcegroup_name" {
    description = "Resouce Group name"
    type        = string
}

variable "region" {
    description = "Location of the resource"
    type        = string
}

#####################################################
# Tags
#####################################################

variable "tags" {
  description = "Tags for finding or sorting resources"
  type = map(string)
  default = {}
}