# Azure Active Directory Home Lab

## Overview

This project demonstrates the deployment, administration, and automation of an enterprise-style Active Directory environment hosted in Microsoft Azure.

The goal of this project is to simulate the responsibilities of a Cloud Engineer, Systems Administrator, or IT Administrator by building and managing a production-like Windows Server environment while automating common administrative tasks using PowerShell.

---

## Architecture

                 Azure
                    │
         Resource Group
                    │
            Virtual Network
          ┌─────────┴─────────┐
          │                   │
      DC-01               CLIENT-01
          │
 Active Directory Domain
      corp.local
          │
 ┌───────────────────────────┐
 │ Organizational Units      │
 │ Security Groups           │
 │ Users                     │
 └───────────────────────────┘
          │
      PowerShell
          │
 ImportUsers.csv
          │
 CreateUsers.ps1
          │
 ├── Create Users
 ├── Assign OU
 ├── Add Group
 ├── Log Results
 └── Skip Duplicates

*Figure 1. High-level architecture of the Azure Active Directory Home Lab, illustrating the Azure infrastructure, Active Directory domain, organizational structure, and PowerShell automation workflow.*

---

## Technologies Used

- Microsoft Azure
- Windows Server 2022
- Active Directory Domain Services (AD DS)
- DNS
- Group Policy
- SMB File Shares
- PowerShell
- Git
- GitHub
- Visual Studio Code

---

## Features Implemented

### Azure Infrastructure
- Azure Resource Group
- Virtual Network
- Domain Controller VM
- Windows Client VM
 


### Active Directory
- Domain Controller Promotion
- Organizational Units (OUs)
- User Accounts
- Security Groups
- Group Membership

### Group Policy
- Created and linked custom Group Policy Objects (GPOs)

### File Services
- Departmental SMB File Shares
- NTFS Permissions
- Share Permissions

### PowerShell Automation
- Import employee data from CSV
- Process employee objects with loops
- Dynamic username generation
- User provisioning automation (in progress)

---

## Project Structure

```text
Azure-AD-Lab
│
├── Documentation
├── Screenshots
├── Scripts
│   ├── CreateUsers.ps1
│   ├── ResetPasswords.ps1
│   ├── DisableInactiveUsers.ps1
│   ├── UserReport.ps1
│   └── ...
│
└── README.md
```

---

## Skills Demonstrated

This project demonstrates experience with:

- Azure Administration
- Windows Server Administration
- Active Directory Management
- PowerShell Scripting
- Infrastructure Automation
- Git Version Control
- GitHub
- Enterprise File Permissions
- Group Policy Management

---

## Current Progress

- ✅ Azure Infrastructure
- ✅ Domain Controller Deployment
- ✅ Active Directory Installation
- ✅ DNS Configuration
- ✅ Organizational Units
- ✅ Users & Groups
- ✅ Group Policy
- ✅ SMB File Shares
- ✅ PowerShell User Provisioning
- ✅ Automatic OU Assignment
- ✅ Automatic Security Group Assignment
- ✅ Duplicate User Detection
- ✅ Logging
- ✅ Error Handling

---

## Future Improvements

- Password Reset Automation
- Disable Inactive Accounts
- Account Unlock Automation
- User Reporting Dashboard
- Azure Monitor Integration
- Azure Backup
- Azure Update Manager
- Azure Bastion

---

## Author

**Raheem**

Computer Science Student | George Mason University

Building cloud engineering, systems administration, and infrastructure automation projects using Azure, PowerShell, Git, and Windows Server.
