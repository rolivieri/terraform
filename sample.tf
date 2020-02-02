
resource "ibm_resource_group" "group" {
  name = "a-resource-grp"
}

data "ibm_resource_group" "group" {
  name = "a-resource-grp"
}

resource "ibm_resource_instance" "resource_instance" {
  name       = "test-cloudant-tst"
  service    = "cloudantnosqldb"
  plan       = "lite"
  location = "us-south"
  resource_group_id = data.ibm_resource_group.group.id
}