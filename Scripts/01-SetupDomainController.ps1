# ============================================
# DC-01 Domain Controller Setup
# ============================================

# Install Active Directory Domain Services
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Create the corp.local forest and promote this server
# to a domain controller.
Install-ADDSForest `
    -DomainName "corp.local" `
    -DomainNetbiosName "CORP" `
    -InstallDNS `
    -Force