terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("data-infrastructure-383014-f1b7fa444061.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  credentials = file("data-infrastructure-383014-f1b7fa444061.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "composer_api" {
  provider = google-beta
  project = var.project
  service = "composer.googleapis.com"
  disable_on_destroy = false
}

resource "google_service_account" "composer_sa" {
  provider = google-beta
  project = var.project
  account_id   = "composer-sa"
  display_name = "Service account for "
}

resource "google_project_iam_member" "iam_composer_sa" {
  provider = google-beta
  project  = var.project
  member   = "serviceAccount:${google_service_account.composer_sa.email}"
  // Role for Public IP environments
  role     = "roles/composer.worker"
}

resource "google_service_account_iam_member" "extension_role_composer_sa" {
  provider = google-beta
  service_account_id = google_service_account.composer_sa.name
  role = "roles/composer.ServiceAgentV2Ext"
  member = "serviceAccount:service-35048300183@cloudcomposer-accounts.iam.gserviceaccount.com"
}


resource "google_composer_environment" "prod_environment" {
  provider = google-beta
  name = "prod-environment"
  labels = {
    owner = "datateam"
    env = "prod"
  }

  config {

    environment_size = "ENVIRONMENT_SIZE_SMALL"
    software_config {
      image_version = "composer-2.1.11-airflow-2.4.3"
      airflow_config_overrides = {
        core-dags_are_paused_at_creation = "True"
        webserver-dag_orientation = "TB"
      }

      pypi_packages = {
          pandas = ">=0.25.3", 
          google-auth = "",
          requests = "",
          dateutils= "",
          google-cloud-storage = "",
          google-cloud-bigquery = "",
          numpy = ""
      }
    }

    node_config {
      service_account = google_service_account.composer_sa.email
    }

  }
}
