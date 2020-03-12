resource "ibm_resource_instance" "mos-sysdig" {
  name              = "Sysdig-MOS"
  service           = "sysdig-monitor"
  plan              = "graduated-tier"
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.mos_rg.id}"
}

resource "ibm_resource_instance" "mos-logdna" {
  name              = "LogDNA-MOS"
  service           = "logdna"
  plan              = "30-day"
  location          = "${var.ibm_region}"
  resource_group_id = "${data.ibm_resource_group.mos_rg.id}"
}

resource "ibm_resource_instance" "mos-object-storage" {
  name              = "Cloud Object Storage-MOS"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = "${data.ibm_resource_group.mos_rg.id}"
}

resource "ibm_container_cluster" "mos-cluster" {
  name              = "IKS-Cluster-MOS"
  datacenter        = "dal10"
  machine_type      = "b3c.4x16"
  hardware          = "dedicated"
  default_pool_size = "${var.default_pool_size}"
  public_vlan_id    = "${element(var.public_vlan_ids, 0)}"
  private_vlan_id   = "${element(var.private_vlan_ids, 0)}"
  resource_group_id = "${data.ibm_resource_group.mos_rg.id}"
}

resource ibm_container_worker_pool_zone_attachment multi_zone {
    count             = "${length(var.zones) - 1}"
    resource_group_id = "${data.ibm_resource_group.mos_rg.id}"
    cluster           = "${ibm_container_cluster.mos-cluster.id}"
    worker_pool       = "${ibm_container_cluster.mos-cluster.worker_pools.0.id}"
    zone              = "${element(var.zones, count.index + 1)}"
    public_vlan_id    = "${element(var.public_vlan_ids, count.index + 1)}"
    private_vlan_id   = "${element(var.private_vlan_ids, count.index + 1)}"
}

