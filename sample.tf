resource "ibm_resource_group" "olivieri_grp" {
  name = "olivieri_grp1"
}

resource "ibm_resource_instance" "olivieri-sysdig" {
  name              = "olivieri-sysdig"
  service           = "sysdig-monitor"
  plan              = "graduated-tier"
  location          = "us-south"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

resource "ibm_resource_instance" "olivieri-logdna" {
  name              = "olivieri-logdna"
  service           = "logdna"
  plan              = "30-day"
  location          = "us-south"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

resource "ibm_resource_instance" "olivieri-object-storage" {
  name              = "olivieri-object-storage"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

#resource "ibm_network_vlan" "public_vlan" {
#  name            = "public_vlan1"
#  datacenter      = "dal10"
#  type            = "PUBLIC"
#}

resource "ibm_container_cluster" "olivieri_cluster" {
  name              = "olivieri_cluster"
  datacenter        = "dal10"
  machine_type      = "b3c.4x16"
  hardware          = "dedicated"
  default_pool_size = 1
  public_vlan_id    = 2779752
  private_vlan_id   = 2779754
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

resource "ibm_container_worker_pool_zone_attachment" "zone2" {
  cluster           = ibm_container_cluster.olivieri_cluster.id
  worker_pool       = "default"
  zone              = "dal12"
  public_vlan_id    = 2799170
  private_vlan_id   = 2799172
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

resource "ibm_container_worker_pool_zone_attachment" "zone3" {
  cluster     = ibm_container_cluster.olivieri_cluster.id
  worker_pool = "default"
  zone        = "dal13"
  public_vlan_id  = 2799166
  private_vlan_id = 2799168
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

resource "ibm_resource_instance" "olivieri-portworx" {
  name              = "olivieri-portworx"
  service           = "portworx"
  plan              = "px-enterprise"
  location          = "us-south"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

