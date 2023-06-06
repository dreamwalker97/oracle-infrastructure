resource "oci_core_network_security_group" "LbSG" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "LbSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "LBEgressRule" {
  network_security_group_id = oci_core_network_security_group.LbSG.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "LBIngressRules" {
  network_security_group_id = oci_core_network_security_group.LbSG.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}


resource "oci_core_network_security_group" "WebSG" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "WebSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "WebEgressATPRule" {
  network_security_group_id = oci_core_network_security_group.WebSG.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_network_security_group.AtpSG.id
  destination_type          = "NETWORK_SECURITY_GROUP"
}
resource "oci_core_network_security_group_security_rule" "WebEgressInternetRule" {
  network_security_group_id = oci_core_network_security_group.WebSG.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_subnet.LBTier.cidr_block
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "WebIngressRules" {
  network_security_group_id = oci_core_network_security_group.WebSG.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_subnet.LBTier.cidr_block
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}


resource "oci_core_network_security_group" "SshSG" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "SshSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "SshEgressRule" {
  network_security_group_id = oci_core_network_security_group.SshSG.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "SshIngressRules" {
  network_security_group_id = oci_core_network_security_group.SshSG.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}


resource "oci_core_network_security_group" "AtpSG" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "AtpSG"
}

# EGRESS
resource "oci_core_network_security_group_security_rule" "AtpEgressRule" {
  network_security_group_id = oci_core_network_security_group.AtpSG.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = oci_core_subnet.WebTier.cidr_block
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "AtpIngressRules" {
  network_security_group_id = oci_core_network_security_group.AtpSG.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = oci_core_subnet.WebTier.cidr_block
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 1522
      min = 1522
    }
  }
}