output "application_hostname" {
  value       = "https://${azurerm_kubernetes_cluster.main.fqdn}"
  description = "The Web application URL."
}
