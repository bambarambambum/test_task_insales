output "mongo" {
  value = google_compute_instance.mongo[*].network_interface.0.access_config.0.nat_ip
}