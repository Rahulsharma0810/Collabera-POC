module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "26.1.1"
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
  zones                      = ["us-central1-a"]
  regional                   = true
  network                    = module.vpc.network_name
  subnetwork                 = module.vpc.subnets_names[0]
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = true
  default_max_pods_per_node  = 50
  remove_default_node_pool   = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  create_service_account     = false
  node_pools                 = var.node_pools
  node_pools_labels          = var.node_pools_labels
  #service_account            = var.gke_service_account


  node_pools_oauth_scopes = {
    all = ["https://www.googleapis.com/auth/cloud-platform", ]
  }
}
