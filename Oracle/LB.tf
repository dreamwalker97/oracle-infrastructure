resource "oci_load_balancer_load_balancer" "load_balancer" {
    compartment_id = var.compartment_ocid
    display_name = "LB"
    shape = "flexible"
    subnet_ids = [oci_core_subnet.LBTier.id]

    shape_details {
        maximum_bandwidth_in_mbps = var.load_balencer_max_band
        minimum_bandwidth_in_mbps = var.load_balencer_min_band
    }
    network_security_group_ids = [oci_core_network_security_group.LbSG.id]
}

resource "oci_load_balancer_backend_set" "backend_set" {

    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    health_checker {
        protocol = "HTTP" 
    }
    name = "Backend set LB"
    policy = "LEAST_CONNECTIONS"
}

resource "oci_load_balancer_backend" "backend01" {

    backendset_name = oci_load_balancer_backend_set.backend_set.name
    ip_address = oci_core_instance.WebServer1.private_ip
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    port = "80"
}


resource "oci_load_balancer_backend" "backend02" {

    backendset_name = oci_load_balancer_backend_set.backend_set.name
    ip_address = oci_core_instance.WebServer2.private_ip
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    port = "80"
}



resource "oci_load_balancer_listener" "listener" {
    default_backend_set_name = oci_load_balancer_backend_set.backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.load_balancer.id
    name = "listener"
    port = "80"
    protocol = "HTTP"
}
