
data "ibm_resource_group" "group" {
  name = "default-resource-grp"
}

resource "ibm_resource_instance" "resource_instance" {
  name       = "test-cloudant-tst"
  service    = "cloudantnosqldb"
  plan       = "lite"
  location = "us-south"
}