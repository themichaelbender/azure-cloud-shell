#### Demo Script



##############################################
##### Intro
##############################################

# Open Azure Portal
www.azure.com

Configure Azure Storage for Cloud Shell
Show Advanced Storage Settings



Show  Cloud Shell Settings to configure Text Size etc


az
dir



show ssh tool and SSH into VM

cd $HOME
cd clouddrive
./New-LinVM.azcli 


##############################################
##### Azure PowerShell Expierence & Code & Uploads/Downloads of Files
##############################################

get-command get-AzVM* 
get-help get-azvm
get-command *AzureAD* | more


#PowerShell v1.5.0 is finally possible to do things like 
Get-AzVM -Name lin* 
Get-AzVM -ResourceGroupName *cloudshell*

Find-Module


cd $HOME
cd cloudshell 
cd scripts
dir


Upload and Download Files in the UI
Export-File 

##############################################
##### Azure Drive
##############################################


Get-PSDrive
cd Azure: 
dir
...



##############################################
##### Azure Cloud Shell Persistent Storage
##############################################

cd $HOME
Get-command *clouddrive*
clouddrive
Get-CloudDrive

# Azure Portal
# Resource Group (Cloud Shell)
# Storage Account 
# Azure Files
# Explore File Share
# Taling about presitent of clouddrive as well as the $HOME


##############################################
##### Editors
##############################################
get-command vi,nano,emacs
cd $HOME
cd cloudshell 
cd scripts
code New-WinVM.ps1





##############################################
##### Cloud Shell Tools
##############################################

Get-Module -ListAvailable

https://docs.microsoft.com/en-us/azure/cloud-shell/features#tools/?WT.mc_id=THOMASMAURER-blog-thmaure




##############################################
##### VSCode Integration
##############################################


#Working with Visual Studio Code

#Walk through extensions to add

#PowerShell

#Azure Account
#ctrl+shift+P to drop command pallette
#Azure Open PowerShell in Cloud Shell
Get-AzVM #Run Slelected Text
Access Azure Clouddrive 









##############################################
##### Azure VM Remoting Demo
##############################################


#Show SSH to linux VM in Azure Portal


get-command -Module PSCloudShellUtility


# Windows VM
Enable-AzVMPSRemoting -Name winvm01 -ResourceGroupName demo-cloudshell-rg -Protocol https -OsType Windows

# Linux VM
Enable-AzVMPSRemoting -Name linuxvm01 -ResourceGroupName demo-cloudshell-rg -Protocol ssh -OsType Linux


$cred = Get-Credential

# Windows VM
Invoke-AzVMCommand -Name winvm01 -ResourceGroupName demo-cloudshell-rg -ScriptBlock {get-service win*} -Credential $cred

# Linux VM
Invoke-AzVMCommand -Name tmdemowin-01 -ResourceGroupName demo-cloudshell-rg -ScriptBlock {uname -a} -UserName thomas -KeyFilePath /home/thomas/.ssh/id_rsa

Enter-AzVM -name winvm01 -ResourceGroupName demo-cloudshell-rg -Credential $cred


##############################################
##### GIT DEMO
##############################################


#show github repo

cd $home/clouddrive

mkdir github

cd ./github

git config --global user.email "thomas.maurer@contoso.com"
git config --global user.name "ThomasMaurer"

git clone https://github.com/thomasmaurer/demo-cloudshell.git

dir

# TODO
Deploy ARM TEMPALTE 


maybe git fetch demo with changes in visual studio 




##############################################
##### Integration
##############################################
Azure Portal
shell.azure.com
Docs 
Microsoft Learn 

Phone 






https://www.thomasmaurer.ch/2019/01/azure-cloud-shell/