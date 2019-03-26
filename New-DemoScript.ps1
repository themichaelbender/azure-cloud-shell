
## Pre-Reqs
[Azure Subscription](https://azure.microsoft.com/en-us/free/?WT.mc_id=MSIgniteTheTour-github-mibender)

Deploy Windows VM
Deploy Linux VM
Azure Account extension
Node.js install

#Region - Demo 1 - Exploring the Shell
# This series of demos includes the setup, configuration, and exploration of Azure Cloud Shell. 
  #Initial Config
    https://shell.azure.com 
  #Add Storage to Subscription (Advanced)
  
  #Browse Resources in Shell
    dir
    cd mibender
    cd ./VirtualMachines/
    dir

  #Find Commands
    get-command get-AzVM*
    get-command *AzureAD* | more
    help Get-AzVM #Rememeber :q
    Get-AzVm
    get-AzVm -name vm-linux-01 | FL
    get-AzVm -name vm-linux-01 | select -ExpandProperty StorageProfile
    (get-AzVm -name vm-linux-01 | select -ExpandProperty StorageProfile).ImageReference
  
  #Browse Cloud Drive
    cd $Home
    dir
    cd clouddrive
    dir
    mkdir DemoDirectory
    cd DemoDirectory
    dir
  
  #Install tools from PowerShell Gallery
    Install-Module PSTeachingTools
    get-command -module PSTeachingTools
#Endregion

#Region - Demo 2 -Working with Visual Studio Code
  #Walk through extensions to add
    #PowerShell
    #Azure Account
      #ctrl+shift+P to drop command pallette
      #Azure Open PowerShell in Cloud Shell
      Get-AzVM #Run Slelected Text
  
#Endregion

#Region -Demo 3 - Remoting into VMs
T#This set of demos covers remoting into VMs in Azure.
  # View commands in Azure Cloud Shell for Remoting
  gcm *azVMPS*, Invoke-AzVMc*,Enter-AzVm*

  # confiugre SSH

  # Generate SSH Key
  ssh-keygen -t rsa -b 2048

  # Verify Key
    ls -al ~/.ssh
    cat ~/.ssh/id_rsa.pub #List public key

  # Add SSH key to linux vm
     ssh-copy-id -i ~/.ssh/id_rsa.pub michael@vm-linux-02.westus2.cloudapp.azure.com

  #  for reference (https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed)

  # Variables
  $win = 'vm-win-01'
  $lnx = 'vm-linux-02'
  $rsg = 'azure-cloudshell-demo'
  $cred = get-credential

  # Windows VM
  Enable-AzVMPSRemoting -Name $win -ResourceGroupName $rsg -Protocol https -OsType Windows

  # Linux VM
  Enable-AzVMPSRemoting -Name $lnx -ResourceGroupName $rsg -Protocol ssh -OsType Linux

  # Run command on Windows VM using Invoke-Command
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

  New-AzureRmResourceGroupDeployment -Name 'cloudshell-demo-deploy' -ResourceGroupName 'cloudshell-demo-mibender3' -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-automatic-static-ip/azuredeploy.json 

  get-azResource -ResourceGroupName 'cloudshell-demo-bender' | Format-Table

    # Take 2
    New-AzResourceGroup -Name 'cloudshell-demo-mibender3' -location 'westeurope'

    get-azResource -ResourceGroupName 'cloudshell-demo-mibender3'
  
    New-AzureRmResourceGroupDeployment -Name 'cloudshell-demo-deploy2' -ResourceGroupName 'cloudshell-demo-mibender3' -TemplateUri https://github.com/themichaelbender-ms/azure-cloud-shell/blob/master/Scripts/ExportedTemplate-azure-cloudshell-demo-linux/template.json

#Setting up GIT
  cd $home/clouddrive
  mkdir github
  cd ./github
  git config --global user.email "mbender@tailwindtraders.net"
  git config --global user.name "mbender"
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