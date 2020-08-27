provider "google" {
  project = var.project
  region  = var.region
}

// Mongo Instances
resource "google_compute_instance" "mongo" {
  count        = 3
  name         = "mongo-${count.index + 1}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["mongo"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
  network_interface {
    network = "default"
    access_config {}
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
}

// Firewall rules
resource "google_compute_firewall" "firewall_mongo" {
  name    = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = var.mongo_default_port
  }
  target_tags = ["mongo"]
  source_tags = ["mongo"]
}
resource "google_compute_firewall" "firewall_ssh" {
  name    = "default-allow-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.source_ranges]
}