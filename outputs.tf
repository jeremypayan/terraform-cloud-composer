output "composer-webserver-ui" {
  value = google_composer_environment.staging_environment.config
}

output "composer-webserver-ui-prod" {
    value = google_composer_environment.production_environment.config
  }

  output "composer-webserver-ui-production" {
    value = google_composer_environment.prod_environment.config
  }