#VCN
resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_ocid
  cidr_block = var.vcn_cider
  dns_label = var.vcn_dns_label
  display_name = var.vcn_dns_label
}

#IGW
resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name = "${var.vcn_dns_label}igw"
  vcn_id = oci_core_vcn.vcn.id
}

#NAT GW
resource "oci_core_nat_gateway" "nat_gw" {
  compartment_id = var.compartment_ocid
    display_name = "${var.vcn_dns_label}nat_gw"
  vcn_id = oci_core_vcn.vcn.id

}

#public_RT
resource "oci_core_route_table" "PublicRT" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
  display_name = "${var.vcn_dns_label}pubrt"

  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

#private_RT
resource "oci_core_route_table" "PrivateRT" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
  display_name   = "${var.vcn_dns_label}prirt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gw.id
  }
}

#subnet
resource "oci_core_subnet" "LBTier" {
  availability_domain = ""
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
  cidr_block = cidrsubnet(var.vcn_cider, 8, 1)
  display_name = "public${var.dns_label}subnet1"
  dns_label = "public${var.dns_label}subnet1"
  route_table_id = oci_core_route_table.PublicRT.id
}

resource "oci_core_subnet" "WebTier" {
  availability_domain = ""
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
  cidr_block = cidrsubnet(var.vcn_cider, 8, 2)
  display_name = "public${var.dns_label}subnet2"
  dns_label = "public${var.dns_label}subnet2"
  route_table_id = oci_core_route_table.PublicRT.id
}

resource "oci_core_subnet" "DBTier" {
  availability_domain = ""
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn.id
  cidr_block = cidrsubnet(var.vcn_cider, 8, 3)
  display_name = "Private${var.dns_label}subnet1"
  dns_label = "Private${var.dns_label}subnet1"
  route_table_id = oci_core_route_table.PrivateRT.id
}
