# Demo Instructions

#Region - Demo 1 - Exploring the Shell
# This series of demos includes the setup, configuration, and exploration of Azure Cloud Shell. 
  ##############################################
  ##### Initial Configuration of Cloud Shell
  ############################################## 

    https://shell.azure.com 
    
    #Add Storage to Subscription (Advanced)
    
    #Show  Cloud Shell Settings to configure Text Size etc
  
  ##############################################
  ##### Finding Commands
  ##############################################
      get-command -module PSCloudShellUtility
      get-command -module Az
      get-command *AzureAD* | more
      help Get-AzVM #Rememeber :qP
      Get-AzVm
      Get-AzVm -ResourceGroupName 'azure-cloudshell-demo'
      Get-AzVm -name *lin*
      get-AzVm -name vm-linux-01 | FL
      cls
    
  ##############################################
  ##### Azure Drive
  ##############################################
      #Browse Resources in Shell
      Get-PSDrive  
      dir
      cd mibender
      cd ./VirtualMachines/
      dir
      get-AzVm -Name 'vm-win-01'
      #Note that no resource group required when in Azure Drive
      cd Azure:
      cls

  ##############################################
  ##### Azure Cloud Shell Persistent Storage
  ##############################################
    $Home
    cd $HOME
    Get-command *clouddrive*
    clouddrive
    Get-CloudDrive
    cd $Home
    dir
    cd clouddrive
    mkdir Scripts
    cd Scripts
    dir
    cls

  ##############################################
  ##### File Management
  ##############################################
    #Upload and Download Files in the UI & Portal
    #Add ./get-servicestatus.ps1 to DemoDirectory
    Export-file ./get-servicestatus.ps1
 
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
    #explore and Install tools from PowerShell Gallery
    Get-Module -ListAvailable
    Find-Module -name *SQL*
    Install-Module PSTeachingTools
    Import-Module PSTeachingTools
    get-command -module PSTeachingTools
    
    #View Tools and Features website
    https://docs.microsoft.com/en-us/azure/cloud-shell/features#tools/?WT.mc_id=cloudshell-powershellsummit-mibender

    #Region - Working with Terraform

      cd $home
      code ./main.tf 
      
      terraform init 
  
      terraform plan --out plan.out
  
      terraform apply plan.out
  
      #OPen Webpage with FQDN
  
      #Verify Resources
      Get-AzResourceGroup -Name 'vote-resource-group'
      
      get-azResource -ResourceGroupName 'vote-resource-group' | ft
  
       #Remove Resources
       terraform destroy -auto-approve
    #Endregion

  ##############################################
  ##### VSCode Integration
  ##############################################
    #Region - Walk through extensions to add
      #PowerShell
      #Azure Account
      #ctrl+shift+P to drop command pallette
      #Azure Open PowerShell in Cloud Shell
      Get-AzVM #Run Selected Text
      CD $home #Access Cloud Drive
    #Endregion  
  


#Endregion

#Region Demo 2 - VM Management, Deployment and GIT integration
  #Region - VM Remoting
    
  ##############################################
  ##### Azure VM Remoting Demo
  ##############################################  
  #This set of demos covers remoting into VMs in Azure.

   #View commands in Azure Cloud Shell for Remoting
      gcm *azVMPS*, Invoke-AzVMc*,Enter-AzVm*
      
      #Show SSH to linux VM in Azure Portal
      
      #confiugre SSH

      #Generate SSH Key
      ssh-keygen -t rsa -b 2048

      #Verify Key
        ls -al ~/.ssh
        cat ~/.ssh/id_rsa.pub #List public key

      #Add SSH key to linux vm
        ssh-copy-id -i ~/.ssh/id_rsa.pub michael@vm-linux-02.westus2.cloudapp.azure.com

      #  for reference (https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed)

      #Enable Azure PSremoting
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
      $hostname
      get-service win*
      exit

      #Disable Azure PSRemoting
      Disable-AzVMPSRemoting -name $win -ResourceGroupName $rsg
      Disable-AzVMPSRemoting -name $lnx -ResourceGroupName $rsg
      Enter-AzVM -name $win -ResourceGroupName $rsg -Credential $cred
  #Endregion - VM Remoting

    ##############################################
    ##### GIT DEMO
    ##############################################
  
    #Region - Deployment from GitHub
    New-AzResourceGroup -Name 'cloudshell-demo-michael' -location 'westeurope'

    get-azResource -ResourceGroupName 'cloudshell-demo-michael'

    New-AzResourceGroupDeployment -Name 'cloudshell-demo-deploy' -ResourceGroupName 'cloudshell-demo-michael' -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-automatic-static-ip/azuredeploy.json -Verbose

    get-azResource -ResourceGroupName 'cloudshell-demo-michael' | Format-Table
    #Endregion - Deployment from Github

    #Region - GIT Integration
    
        #Setting up GIT
        cd $home/clouddrive
        mkdir github
        cd ./github
        git config --global user.email "mbender@tailwindtraders.net"
        git config --global user.name "mbender"
        git clone https://github.com/themichaelbender-ms/azure-cloud-shell.git
        dir

        #Add Public key to GitHub
        cat ~/.ssh/id_rsa.pub

        # Set remote url to repository; SSH must be created and stored
        cd ./azure-cloud-shell
        git remote set-url origin git@github.com:themichaelbender-ms/azure-cloud-shell.git
        git status
        git branch
        git checkout -b demo-cs
        cd ./scripts
        code ./New-testScript.ps1 # Create a new script, add code, and save Ctrl+S Ctrl+Q
        code ./New-ServiceScript.ps1 #Update Script
        cls
        git status
        git add . # Adds all changes
        git commit -a -m 'New Script and Update'
        git status
        git push -u origin demo-cs
        #If Necessary Commit on GitHub
        #Endregion

    #Endregion


#Region Demo 4 - Access Cloud Shell from everywhere
  # Walk through Cloud Shell in Docs
  # Walk through Cloud Shell in Learn
  # Show demo of Cloud Shell from mobile device using Azure App
#Endregion


