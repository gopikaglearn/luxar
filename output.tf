output "Frontend_URL" {
  value = "http://${var.hostname}.${var.hosted_zone_name}"
}
