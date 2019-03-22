# Master the Cloud with Azure Cloud Shell

You already know PowerShell is the key to on-premises workloads. Now take the power of the shell into the Cloud with Azure Cloud Shell. This demo-packed session will introduce you to Azure Cloud Shell, and provide plenty of tips to be immediately effective in using the command line to manage your Azure resources from anywhere.

## Pre-Reqs
[Azure Subscription](https://azure.microsoft.com/en-us/free/?WT.mc_id=MSIgniteTheTour-github-mibender)

Deploy Windows VM
Deploy Linux VM

## Demo 1 - Exploring the Shell
This series of demos includes the setup, configuration, and exploration of Azure Cloud Shell. 

dir
cd mibender
cd ./VirtualMachines/
dir
get-AzVm -name vm-linux-01 | fl
get-AzVm -name vm-linux-01 | select -ExpandProperty StorageProfile
(get-AzVm -name vm-linux-01 | select -ExpandProperty StorageProfile).ImageReference
15 get-command get-AzVM*
18 get-command *AzureAD* | more
19 Get-AzureADUser
20 cd $Home
21 dir
22 cd windows azure powershell
23 cd 'windows azure powershell'
24 cd clouddrive
25 dir
26 mkdir DemoDirectory
27 cd DemoDirectory
28 dir
29 code
```PowerShell

```
## Demo 2 -Working with Visual Studio Code



1. Intro to cloud shell (2)
   1. Marketing Slides
2. Walk through initial setup (2)
   1. Add drive through advanced settings
   2. Run through taskbar options
   3. View Storage
   4. Upload Script
   5. Open code with {}
3. Exploring the Shell
   1. Dir to view subs
   2. Discuss Azure Drive
   3. Explore down to VMs
4. find Az commands (2)
   1. Find AZ* and AzureAD*
5. Explore to $Home
   1. create directory
   2. Create script in code and save here
   3. Open script
6. Edit Script in VS Code Editor (2)
7. Remote into VMs

```PowerShell
# Enable VMs

```

1. Deploy resources from Azure-Samples (2)
2. Use GIT to clone demo folder w/ Scripts (2)
3.  Show Microsoft Learn module on X and show Azure Cloud Shell (2)
4.  Close with Slide of iphone screen accessing cloud shell (1)
