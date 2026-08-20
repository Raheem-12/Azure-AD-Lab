<#
.SYNOPSIS
Creates Active Directory users from a CSV file.

.DESCRIPTION
Imports employee information from a CSV file,
creates Active Directory users,
places them into the correct Organizational Unit,
and assigns them to the appropriate security group.

.AUTHOR
Raheem

.DATE
2026-07-22
#>

Import-Module ActiveDirectory

# CSV file location
$CsvPath = Join-Path $PSScriptRoot "ImportUsers.csv"

# Prompt securely for the default password
$DefaultPassword = Read-Host "Enter default password for new AD users" -AsSecureString

# Import employee data
Write-Host "Using CSV path: $CsvPath"
$employees = Import-Csv $CsvPath

function Get-OUPath {

    param(
        [string]$Department
    )

    switch ($Department) {

        "IT" {
            return "OU=IT,DC=corp,DC=local"
        }

        "HR" {
            return "OU=HR,DC=corp,DC=local"
        }

        "Finance" {
            return "OU=Finance,DC=corp,DC=local"
        }

        "Sales" {
            return "OU=Sales,DC=corp,DC=local"
        }

        default {
            return $null
        }
    }
}

function Get-SecurityGroup {

    param(
        [string]$Department
    )

    switch ($Department) {

        "IT" {
            return "IT-SG"
        }

        "HR" {
            return "HR-SG"
        }

        "Finance" {
            return "Finance-SG"
        }

        "Sales" {
            return "Sales-SG"
        }

        default {
            return $null
        }
    }
}

foreach ($employee in $employees) {

    $FirstName  = $employee.FirstName
    $LastName   = $employee.LastName
    $Department = $employee.Department

    # Example username: John Smith -> jsmith
    $Username = (
        $FirstName.Substring(0,1) + $LastName
    ).ToLower()

    $OUPath = Get-OUPath -Department $Department
    $Group  = Get-SecurityGroup -Department $Department

    if (-not $OUPath) {
        Write-Warning "Unknown department for $FirstName $LastName. Skipping."
        continue
    }

    # Check whether the user already exists
    $ExistingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$Username'" `
        -ErrorAction SilentlyContinue

    if ($ExistingUser) {

        Write-Host "User already exists: $Username"

	$UserDetails = Get-ADUser `
		-Identity $Username `
		-Properties Enabled, PasswordLastSet

	if (-not $UserDetails.Enabled -or -not $UserDetails.PasswordLastSet) {
		
		try {
		    Set-ADAccountPassword `
			-Identity $Username `
			-NewPassword  $DefaultPassword `
			-Reset `
			-ErrorAction Stop

		    Enable-ADAccount `
	   	        -Identity $Username `
			-ErrorAction Stop

		   Write-Host "Repaired and enabled user: $Username"

	       }
               catch {
		   Write-Host "Failed to repair user: $Username"
	     	   Write-Host "Error: $($_.Exception.Message)"
		   continue
		}
	}

    }
    else {
	try {

            New-ADUser `
            	-Name "$FirstName $LastName" `
            	-GivenName $FirstName `
            	-Surname $LastName `
            	-SamAccountName $Username `
            	-UserPrincipalName "$Username@corp.local" `
            	-Path $OUPath `
            	-Department $Department `
            	-AccountPassword $DefaultPassword `
            	-Enabled $true `
            	-ChangePasswordAtLogon $true `
		-ErrorAction Stop

             Write-Host "Created user: $Username"
    
	}
	catch {
		Write-Host "Failed to create user: $Username"
		Write-Host "Error: $($_.Exception.Message)"
		continue
	}
	
    }


    # Add user to department security group
    if ($Group) {

        $AlreadyMember = Get-ADGroupMember `
            -Identity $Group `
            -ErrorAction SilentlyContinue |
            Where-Object {
                $_.SamAccountName -eq $Username
            }

        if (-not $AlreadyMember) {

            Add-ADGroupMember `
                -Identity $Group `
                -Members $Username

            Write-Host "Added $Username to $Group"
        }
        else {

            Write-Host "$Username is already a member of $Group"
        }
    }

    Write-Host "----------------------------------"
}