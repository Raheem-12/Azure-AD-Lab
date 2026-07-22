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

# CSV file location
$CsvPath = Join-Path $PSScriptRoot "ImportUsers.csv"

# Default password
$DefaultPassword = ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force

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

# Test the OU path function for each employee
foreach ($employee in $employees) {
    $ouPath = Get-OUPath -Department $employee.Department

    Write-Host "Employee: $($employee.FirstName) $($employee.LastName)"
    Write-Host "Department: $($employee.Department)"
    Write-Host "OU Path: $ouPath"
    Write-Host "------------------------------"
}