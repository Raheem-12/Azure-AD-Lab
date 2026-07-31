# Azure Active Directory Home Lab

## Overview

This project demonstrates the deployment, administration, and automation of an enterprise-style Active Directory environment hosted in Microsoft Azure.

The goal of this project is to simulate the responsibilities of a Cloud Engineer, Systems Administrator, or IT Administrator by building and managing a production-like Windows Server environment while automating common administrative tasks using PowerShell.

---

## Architecture

Azure
│
└── Resource Group
      │
      └── Virtual Network
              │
      ┌───────┴────────┐
      │                │
   DC-01           CLIENT-01
      │
Active Directory
      │
Users
Groups
PowerShell

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
- Provisioned Azure Resource Group
- Configured Virtual Network
- Deployed Windows Server Domain Controller
- Configured Azure networking

### Active Directory
- Installed Active Directory Domain Services (AD DS)
- Promoted the server to a Domain Controller
- Created the `corp.local` domain
- Designed Organizational Unit (OU) structure
- Created and managed user accounts
- Created department-based security groups
- Verified Active Directory configuration using PowerShell

### PowerShell Automation
- Imported employee data from CSV
- Automated Active Directory user provisioning
- Automated Organizational Unit assignment
- Automated security group assignment
- Dynamic username generation
- Duplicate user detection
- Logging and error handling

---

## Build Walkthrough

### 1. Azure Infrastructure

#### Resource Group

<img width="1872" height="745" alt="image" src="https://github.com/user-attachments/assets/083ac2af-8310-4ca5-8fd0-9c48827b5b75" />

Created a dedicated Azure Resource Group (`rg-ad-lab`) to organize all Azure resources associated with the Active Directory environment, including virtual machines, networking, storage, and security resources.

---

#### Virtual Network

<img width="1884" height="735" alt="image" src="https://github.com/user-attachments/assets/0f76d4ae-b1e5-472b-9d25-d13afec77092" />

Configured an Azure Virtual Network (`DC-01-vnet`) with an address space of `10.0.0.0/16` to enable secure communication between virtual machines. The Domain Controller was configured as the DNS server for the network.

---

#### Domain Controller Virtual Machine

<img width="1873" height="739" alt="image" src="https://github.com/user-attachments/assets/cb49e347-3bd8-49f7-bada-a2c75013e499" />

Deployed a Windows Server virtual machine (`DC-01`) that serves as the Domain Controller for the `corp.local` Active Directory domain.

---

### 2. Active Directory Configuration

#### Domain Controller Verification

<img width="1851" height="999" alt="image" src="https://github.com/user-attachments/assets/dc8016f8-6a36-47d6-ae8b-3c9162d3c6aa" />

Verified that the server was successfully promoted to a Domain Controller by confirming the Active Directory domain configuration using PowerShell.

---

#### Organizational Units

<img width="877" height="349" alt="image" src="https://github.com/user-attachments/assets/d71c0038-c60b-48f3-b372-4ffdeef7d437" />

Created Organizational Units (OUs) for IT, HR, Finance, Sales, Servers, and Workstations to organize users and computers according to departmental structure.

---

#### User Accounts

<img width="886" height="363" alt="image" src="https://github.com/user-attachments/assets/fcffecf4-18c1-49c0-b748-b7ff15b4cc53" />

Created and verified Active Directory user accounts for multiple departments within the `corp.local` domain.

---

#### Security Groups

<img width="1374" height="259" alt="image" src="https://github.com/user-attachments/assets/a539222b-9ebd-49ea-80fc-3d4b9dbab143" />

Configured department-based security groups to support role-based access control (RBAC) and simplify permission management.

---

### 3. PowerShell Automation

#### User Provisioning Script

<img width="1171" height="744" alt="image" src="https://github.com/user-attachments/assets/6be5f195-41af-48f0-8263-d328da2d973a" />
<img width="380" height="205" alt="image" src="https://github.com/user-attachments/assets/4ee2ee39-c37f-4dc6-b164-532e0a44ebf2" />


Developed a PowerShell automation script that imports employee information from a CSV file, generates usernames, creates Active Directory user accounts, assigns each user to the correct Organizational Unit, adds them to the appropriate security group, and records all actions in a log file.

---

#### Script Execution

<img width="634" height="172" alt="image" src="https://github.com/user-attachments/assets/47acd10e-f0a3-4e27-80d5-8892cbeb0697" />

Executed the provisioning script to automatically create new users, assign security groups, and place users into their corresponding Organizational Units.

---

#### Logging

<img width="1062" height="270" alt="image" src="https://github.com/user-attachments/assets/ce726d4b-a3d6-4402-b83b-abaa91b89d4e" />

Implemented logging to record provisioning activity, successful account creation, and duplicate-user detection for auditing and troubleshooting.

---

#### Group Membership Validation

<img width="925" height="163" alt="image" src="https://github.com/user-attachments/assets/531fd31c-06ac-4bb9-8c37-ad2651660ede" />

Verified that newly created users were automatically assigned to the appropriate department security groups using PowerShell.

---
## Project Outcomes

Successfully deployed an enterprise-style Active Directory environment in Microsoft Azure.

Implemented:

- Azure Resource Group
- Virtual Network
- Windows Server Domain Controller
- Active Directory Domain Services
- Organizational Units
- Department-based Security Groups
- Automated user provisioning using PowerShell
- Duplicate-user detection
- Automated logging

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
