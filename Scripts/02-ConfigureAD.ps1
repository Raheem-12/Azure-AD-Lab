# ============================================
# Active Directory Configuration
# Run AFTER DC-01 has rebooted
# ============================================

Import-Module ActiveDirectory

# Create Organizational Units
$OUs = @(
    "IT",
    "HR",
    "Finance",
    "Sales",
    "Workstations"
)

foreach ($OU in $OUs) {

    $ExistingOU = Get-ADOrganizationalUnit `
        -Filter "Name -eq '$OU'" `
        -ErrorAction SilentlyContinue # handle a non-terminating error such as "missing OU"

    if (-not $ExistingOU) {

        New-ADOrganizationalUnit `
            -Name $OU `
            -Path "DC=corp,DC=local"

        Write-Host "Created OU: $OU"
    }
    else {
        Write-Host "OU already exists: $OU"
    }
}

# ============================================
# Create Security Groups
# ============================================

$Groups = @(
    "IT-SG",
    "HR-SG",
    "Finance-SG",
    "Sales-SG"
)

foreach ($Group in $Groups) {

    $ExistingGroup = Get-ADGroup `
        -Filter "Name -eq '$Group'" `
        -ErrorAction SilentlyContinue

    if (-not $ExistingGroup) {

        New-ADGroup `
            -Name $Group `
            -GroupScope Global `
            -GroupCategory Security `
            -Path "CN=Users,DC=corp,DC=local"

        Write-Host "Created security group: $Group"
    }
    else {
        Write-Host "Security group already exists: $Group"
    }
}

# ============================================
# Run Existing User Provisioning Script
# ============================================

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

& "$ScriptPath\CreateUsers.ps1"

# ============================================
# Create Department File Shares
# ============================================

$Shares = @{
    "Finance" = "C:\CompanyData\Finance"
    "HR"      = "C:\CompanyData\HR"
    "IT"      = "C:\CompanyData\IT"
    "Sales"   = "C:\CompanyData\Sales"
}

foreach ($ShareName in $Shares.Keys) {

    $Path = $Shares[$ShareName]

    # Create the folder if it does not already exist
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force
        Write-Host "Created folder: $Path"
    }

    # Create the SMB share if it does not already exist
    $ExistingShare = Get-SmbShare `
        -Name $ShareName `
        -ErrorAction SilentlyContinue

    if (-not $ExistingShare) {

        New-SmbShare `
            -Name $ShareName `
            -Path $Path `
            -FullAccess "CORP\Domain Admins"

        Write-Host "Created SMB share: $ShareName"
    }
    else {
        Write-Host "SMB share already exists: $ShareName"
    }
}