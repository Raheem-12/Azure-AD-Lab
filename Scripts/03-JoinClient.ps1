# ============================================
# CLIENT-01 Domain Join
# ============================================

# Domain controller/DNS server IP
$DnsServer = "10.0.0.4"

# Domain to join
$DomainName = "corp.local"

# Find the active network adapter
$Adapter = Get-NetAdapter |
    Where-Object { $_.Status -eq "Up" } |
    Select-Object -First 1

# Point CLIENT-01 DNS to DC-01
Set-DnsClientServerAddress `
    -InterfaceIndex $Adapter.ifIndex `
    -ServerAddresses $DnsServer

Write-Host "DNS configured to use $DnsServer"

# Prompt for domain credentials securely
$Credential = Get-Credential -Message "Enter CORP domain administrator credentials"

# Join CLIENT-01 to corp.local and reboot
Add-Computer `
    -DomainName $DomainName `
    -Credential $Credential `
    -Restart `
    -Force
    