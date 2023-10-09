resource "google_service_account" "sa" {
  project    = var.project_id
  account_id = var.sa_name
}

module "oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = var.pool_id
  provider_id = var.provider_id
  issuer_uri  = var.issuer_uri
  sa_mapping = {
    (google_service_account.sa.account_id) = {
      sa_name = google_service_account.sa.name
      #attribute = "attribute.repository/user/repo"
      attribute = var.sa_mapping_attribute
    }
  }
}
