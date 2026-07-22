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
$CsvPath = ".\ImportUsers.csv"

# Default password
$DefaultPassword = ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force

# Import employee data
$employees = Import-Csv $CsvPath