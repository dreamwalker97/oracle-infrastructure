variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}

variable "region" {
  default = "eu-amsterdam-1"
}

variable "AD" {
  default = "1"
}

variable "vcn_cider" {
  default = "10.0.0.0/16"
}

variable "vcn_dns_label" {
  description = "VCN DNS Label"
  default = "vcn01"
}

variable "dns_label" {
  description = "subnet DNS Label"
  default = "subnet"  
}

variable "image_operating_system" {
  default = "Oracle Linux"
}

variable "image_operating_system_version" {
  default = "8"
}

variable "instance_shape" {
  description = "Instance Shape"
  default = "VM.Standard.E2.1.Micro"
}


variable "load_balencer_min_band" {
  description = "Load Balencer min band"
  default = "10"
}

variable "load_balencer_max_band" {
  description = "Load Balencer max band"
  default = "10"
}

/*
variable "ATP_database_db_name" {
  default = "aTPdb"
}

variable "ATP_database_cpu_core_count" {
  default = 1
}
variable "ATP_password" {}

variable "ATP_database_data_storage_size_in_tbs" {
  default = 1
}
*/

