resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "${var.resource_prefix}-ASP01"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app_service" {
  name                = var.app_service_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
  https_only          = true
  
  site_config {
    always_on        = true
    ftps_state       = "AllAllowed"
    min_tls_version  = "1.2"
    linux_fx_version = "COMPOSE|${filebase64("docker-compose.yml")}"
  }

  app_settings = {
    "MYSQL_ROOT_PASSWORD"                 = var.mysql_root_password
    "MYSQL_PASSWORD"                      = var.mysql_password
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = true
  }

  storage_account {
    name         = "1"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storageaccount.name
    share_name   = azurerm_storage_share.storageshare_database.name
    access_key   = azurerm_storage_account.storageaccount.primary_access_key
    mount_path   = "/config1/"
  }

  storage_account {
    name         = "2"
    type         = "AzureFiles"
    account_name = azurerm_storage_account.storageaccount.name
    share_name   = azurerm_storage_share.storageshare_wordpress.name
    access_key   = azurerm_storage_account.storageaccount.primary_access_key
    mount_path   = "/config2/"
  }
}