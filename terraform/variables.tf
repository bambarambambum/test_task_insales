variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default = "europe-west1"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used to connect to instance"
}
variable private_key_path {
  description = "Path to the private key used to connect to instance"
}

variable disk_image {
  description = "Disk image for mongo"
  default     = "ubuntu-1804-lts"
}
variable "machine_type" {
  description = "Standart machine type"
  default     = "n1-standard-1"
}
variable "mongo_default_port" {
  description = "MongoDB default port"
  default     = ["27017"]
}
variable "source_ranges" {
  description = "IP Source range"
}