
## Pre-Reqs
[Azure Subscrition](https://azure.microsoft.com/en-us/free/?WT.mc_id=MSIgniteTheTour-github-mibender)

Deploy Windows VM
Deploy Linux VM
Azure Account extension
Node.js install

#Region - Demo 1 - Exploring the Shell
This series of demos includes the setup, configuration, and exploration of Azure Cloud Shell. 

  dir
  cd mibender
  cd ./VirtualMachines/
  dir
  get-AzVm -name vm-linux-01 | fl
  get-AzVm -name vm-linux-01 | select -ExpandProperty StorageProfile
  (get-AzVm -name vm-linux-01 | select -ExpandProperty StorageProfile).ImageReference
  get-command get-AzVM*
  get-command *AzureAD* | more
  Get-AzureADUser
  cd $Home
  dir
  cd clouddrive
  dir
  mkdir DemoDirectory
  cd DemoDirectory
  dir
  code
#Endregion

## Demo 2 -Working with Visual Studio Code
ctrl+shift+P to drop command pallette
Azure: Open Cloud Shell in VS Code

#Region -Demo 3 - Remoting into VMs
This set of demos covers remoting into VMs in Azure.

```PowerShell
# View commands in Azure Cloud Shell for Remoting
gcm *azVMPS*, Invoke-AzVMc*,Enter-AzVm*

# confiugre SSH

# Generate Key
ssh-keygen -t rsa -b 2048
# Verify Key
cat ~./ssh/isa
ls -al ~/.ssh
for reference (https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed)
# Variables
$win = 'vm-win-01'
$lnx = 'vm-linux-01'
$rsg = 'azure-cloudshell-demo'
$cred = get-credential

# Windows VM
Enable-AzVMPSRemoting -Name $win -ResourceGroupName $rsg -Protocol https -OsType Windows

# Linux VM
Enable-AzVMPSRemoting -Name $lnx -ResourceGroupName $rsg -Protocol ssh -OsType Linux

# Fan Out to VMs
# Windows VM
Invoke-AzVMCommand -Name $win -ResourceGroupName $rsg -ScriptBlock {get-service win*} -Credential $cred

# Linux VM - display current software and hardware information with uname
Invoke-AzVMCommand -Name $lnx -ResourceGroupName $rsg -ScriptBlock {uname -a} -UserName michael -KeyFilePath /home/michael/.ssh/id_rsa

# Connect to VM with Remoting

Enter-AzVM -name $win -ResourceGroupName $rsg -Credential $cred
whoami
get-service win*
exit

#Endregion

#Region - Demo 4 - Deploying Resources and GIT
  New-AzResourceGroup -Name 'cloudshell-demo-bender' -location 'westeurope'

  get-azResource -ResourceGroupName 'cloudshell-demo-bender'

  New-AzureRmResourceGroupDeployment -Name 'cloudshell-demo-deploy' -ResourceGroupName 'cloudshell-demo-bender' -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-automatic-static-ip/azuredeploy.json 

  get-job | format-list

  get-azResource -ResourceGroupName 'cloudshell-demo-bender'

  get-azResource -ResourceGroupName 'cloudshell-demo-bender' | Format-Table

#Setting up GIT
  cd $home/clouddrive
  mkdir github
  cd ./github
  git clone https://github.com/themichaelbender-ms/azure-cloud-shell.git
  dir
# Set remote url to repository; SSH must be created and stored
  cd ./azure-cloud-shell
  git remote set-url origin git@github.com:themichaelbender-ms/azure-cloud-shell.git
  git status
  git branch
  git checkout -b demo-cs
  code ./New-ServiceScript.ps1 # Create a new script, add code, and save
  git status
  git add . # Adds all changes
  git commit -m 'New Script'
  git status
  git push -u origin demo-cs

#Endregion