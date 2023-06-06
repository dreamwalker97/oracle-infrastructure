resource "oci_database_autonomous_database" "ATPdatabase" {
    compartment_id = var.compartment_ocid
    cpu_core_count = var.ATP_database_cpu_core_count
    db_name = var.ATP_database_db_name
    admin_password = var.ATP_password
    data_storage_size_in_tbs = var.ATP_database_data_storage_size_in_tbs


}