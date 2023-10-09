module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.4"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"

  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}
