##############################################################################
# Sensitive Account Variables
##############################################################################

variable ibmcloud_api_key {
    description = "IBM Cloud IAM API Key"
}

variable resource_group {
    description = "Name of resource group to provision resources"
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    default     = "us-south"
}

##############################################################################



##############################################################################
# Network Variables
##############################################################################

variable public_vlan_ids {
  description = "List of public vlans. The first will be for the master, any additional will be for worker pools"
  type        = "list"

}

variable private_vlan_ids {
  description = "List of private vlans The first will be for the master, any additional will be for worker pools"
  type        = "list"
}


variable zones {
  description = "List of cluster zones The first will be for the master, any additional will be for worker pools"
  type        = "list"

}


##############################################################################
# Cluster Variables
##############################################################################

variable kube_version {
  description = "Kube version to use for the cluster. use `ibmcloud ks versions` to see a list of available versions"
  default     = "1.16.7"
}

variable default_pool_size {
  description = "Default pool size for cluster"
  default     = 1  
}

##############################################################################