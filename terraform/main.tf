
resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = var.sa_name
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

module "oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = var.pool_id
  provider_id = var.provider_id
  issuer_uri = var.issuer_uri
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name   = google_service_account.sa.name
      #attribute = "attribute.repository/user/repo"
      attribute = var.sa_mapping_attribute
    }
  }
}

resource "google_artifact_registry_repository" "my-repo" {
  project = var.project_id
  location      = var.location
  repository_id = var.repository_id
  description   = "Docker repository managed by tf"
  format        = "DOCKER"
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.4"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets = var.subnets
  secondary_ranges = var.secondary_ranges
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "26.1.1"
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
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