# Create Project
resource "digitalocean_project" "obsidian_notes_project" {
  name        = "Obsidian Notes"
  purpose     = "Note taking and synchronization"
  environment = "Production"
}

# Create Spaces storage bucket
resource "digitalocean_spaces_bucket" "obsidian_notes_bucket" {
  name   = "obsidian-notes-storage"
  region = "tor1"
  acl    = "private"

}

# Create CDN endpoint
resource "digitalocean_certificate" "cert" {
  name    = "obsidian-notes-cdn-cert"
  type    = "lets_encrypt"
  domains = ["obsidian-notes.tngdo.com"]
}

# Add CDN endpoint with custom sub-domain to Spaces bucket
resource "digitalocean_cdn" "obsidian-notes-cdn" {
  origin           = digitalocean_spaces_bucket.obsidian_notes_bucket.bucket_domain_name
  custom_domain    = "obsidian-notes.tngdo.com"
  certificate_name = digitalocean_certificate.cert.name
}