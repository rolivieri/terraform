
resource "ibm_resource_group" "my_grp" {
  name = "my-resource-grp"
}

resource "ibm_resource_instance" "cloudant_instance" {
  name              = "test-cloudant-tst"
  service           = "cloudantnosqldb"
  plan              = "lite"
  location          = "us-south"
  resource_group_id = ibm_resource_group.my_grp.id
}

# The Kubernetes Cluster Resource
resource "ibm_container_cluster" "mycluster-terraform" {
  name              = "mycluster-terraform"
  datacenter        = "dal10"
  machine_type      = "free"
  hardware          = "shared"
  default_pool_size = 1
  resource_group_id = ibm_resource_group.my_grp.id
}
