  
  ##############################################
  ##### File Management
  ##############################################
    #Upload and Download Files in the UI & Portal
    #Add ./get-servicestatus.ps1 to Scripts

    ## Upload New-WinVM.ps1 to Cloud Shell

    export-file new-psscript.ps1
 
  ##############################################
  ##### Editors
  ##############################################
    get-command vi,nano,emacs
    cd $HOME
    cd cloudshell 
    cd scripts
    code New-WinVM.ps1
    cls

  ##############################################
  ##### Cloud Shell Tools
  ##############################################
    #explore and Install tools from PowerShell Gallery
    Get-Module -ListAvailable
    Find-Module -name *SQL*
    Install-Module PowerShellAI
    Import-Module PowerShellAI
    get-command -module PowerShellAI
    cls
