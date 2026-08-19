# Tells Terraform which Azure provider (azurerm) it needs
# so Terraform knows how to communicate with Azure.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configures Terraform to use the Azure provider.
# The "az login" authentication allows Terraform to access my Azure account.
provider "azurerm" {
  features {}
}

# Defines the Azure Resource Group that Terraform will manage.
resource "azurerm_resource_group" "ad_lab" {
  name     = "rg-ad-lab"
  location = "eastus"
}

# Defines the existing virtual network used by the AD lab.
resource "azurerm_virtual_network" "ad_vnet" {
  name                = "DC-01-vnet"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name
  address_space       = ["10.0.0.0/16"]

  dns_servers = ["10.0.0.4"]
}

# Defines the subnet inside the AD lab virtual network.
resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.ad_lab.name
  virtual_network_name = azurerm_virtual_network.ad_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Defines the Network Security Group for the domain controller/
resource "azurerm_network_security_group" "dc_nsg" {
  name                = "DC-01-nsg"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name
}

# Defines the Network Security Group for the client VM.
resource "azurerm_network_security_group" "client_nsg" {
  name                = "CLIENT-01-nsg"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name
}


# Defines the public IP used by the Domain controller
resource "azurerm_public_ip" "dc_public_ip" {
  name                = "DC-01-ip"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name

  allocation_method = "Static"
  sku               = "Standard"
  ip_version        = "IPv4"
}

# Defines the network interface used by the domain controller VM.
resource "azurerm_network_interface" "dc_nic" {
  name                = "dc-01158"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = azurerm_public_ip.dc_public_ip.id
  }
}

# Associates the DC-01 NSG with the DC-01 network interface.
resource "azurerm_network_interface_security_group_association" "dc_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.dc_nic.id
  network_security_group_id = azurerm_network_security_group.dc_nsg.id
}

# Defines the Windows Server VM used as the domain controller.
resource "azurerm_windows_virtual_machine" "dc_vm" {
  name                = "DC-01"
  computer_name       = "DC-01"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name
  size                = "Standard_D2s_v3"

  admin_username = "azureadmin"
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.dc_nic.id
  ]

  os_disk {
    name                 = "DC-01_OsDisk_1_82b7cc599c714514993ac02243746f08"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver2022"
    sku       = "2022-datacenter-azure-edition-core"
    version   = "latest"
  }

  automatic_updates_enabled = true

  reboot_setting = "IfRequired"

  additional_capabilities {
    hibernation_enabled = false
  }

  boot_diagnostics {}
}

#############################

# Defines the network interface for CLIENT-01.
resource "azurerm_network_interface" "client_nic" {
  name                = "CLIENT-01-nic"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Associates the CLIENT-01 NSG with the client network interface.
resource "azurerm_network_interface_security_group_association" "client_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.client_nic.id
  network_security_group_id = azurerm_network_security_group.client_nsg.id
}

# Defines the Windows client VM used to join the corp.local domain.
resource "azurerm_windows_virtual_machine" "client_vm" {
  name                = "CLIENT-01"
  computer_name       = "CLIENT-01"
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.ad_lab.name

  size = "Standard_D2s_v3"

  admin_username = "azureadmin"
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.client_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-ent"
    version   = "latest"
  }

  boot_diagnostics {}
}





