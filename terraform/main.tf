resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_artifact_registry_repository" "my-repo" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_id
  description   = "Docker repository managed by tf"
  format        = "DOCKER"
}
