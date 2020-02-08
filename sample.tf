resource "ibm_resource_group" "olivieri_grp" {
  name = "olivieri_group"
}

resource "ibm_resource_instance" "olivieri-sysdig" {
  name              = "olivieri-sysdig"
  service           = "sysdig-monitor"
  plan              = "graduated-tier"
  location          = "us-south"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

# The Kubernetes Cluster Resource
#resource "ibm_container_cluster" "olivieri-mycluster-terraform" {
#  name              = "mycluster-terraform"
#  datacenter        = "dal10"
#  machine_type      = "free"
#  hardware          = "shared"
#  default_pool_size = 1
#  resource_group_id = ibm_resource_group.olivieri_grp.id
#}

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
  cluster     = ibm_container_cluster.olivieri_cluster.id
  worker_pool = "default"
  zone        = "dal12"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}

resource "ibm_container_worker_pool_zone_attachment" "zone3" {
  cluster     = ibm_container_cluster.olivieri_cluster.id
  worker_pool = "default"
  zone        = "dal13"
  resource_group_id = ibm_resource_group.olivieri_grp.id
}
