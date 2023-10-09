project_id = "prod-rvsharma-com"
pool_id = "rv-tf-gh-pool"
provider_id = "rv-tf-gh-provider"
sa_mapping_attribute = "attribute.repository/shrutipawar2711/tf-poc"
sa_name = "rv-tf-sa"

location = "us-central1"
repository_id = "rv-docker-repo"

subnets = [
{
subnet_name   = "subnet-01"
subnet_ip     = "10.206.0.0/20"
subnet_region = "us-central1"
},
]

network_name = "rv-vpc"

secondary_ranges = {
  subnet-01 = [
    {
      range_name    = "gke-pods-cidr"
      ip_cidr_range = "10.207.0.0/16"
    },
    {
      range_name    = "gke-services-cidr"
      ip_cidr_range = "10.208.0.0/20"
    },
  ]
}

cluster_name      = "rv-cluster"
region            = "us-central1"
ip_range_pods     = "gke-pods-cidr"
ip_range_services = "gke-services-cidr"
node_pools = [
  {
    name               = "app-node-pool"
    machine_type       = "e2-medium"
    min_count          = 1
    max_count          = 5
    local_ssd_count    = 0
    disk_size_gb       = 100
    disk_type          = "pd-standard"
    image_type         = "COS_CONTAINERD"
    enable_gcfs        = false
    auto_repair        = true
    auto_upgrade       = true
    preemptible        = false
    initial_node_count = 1
  },
]

node_pools_labels = {

  app-node-pool = {
    org       = "test"
    createdby = "terraform"
  }
}
