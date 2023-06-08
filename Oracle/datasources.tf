# Get a list of supported images based on the shape, operating system and operation system version
data "oci_core_images" "compute_images" {
  compartment_id = var.compartment_ocid
  operating_system = var.image_operating_system
  operating_system_version = var.image_operating_system_version
  shape = var.instance_shape
  sort_by = "TIMECREATED"
  sort_order = "DESC"
}
