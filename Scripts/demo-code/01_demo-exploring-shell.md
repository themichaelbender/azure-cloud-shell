##############################################
  ##### Finding Commands
  ##############################################
      get-command -module PSCloudShellUtility
##F2
      get-Module -Name Az*
      get-command -name *VirtualNetwork
      help Get-AzVirtualNetwork
      Get-AzVirtualNetwork
      Get-AzVirtualNetwork | format-table -Property Name,AddressSpace
    
  ##############################################
  ##### Azure Drive
  ##############################################
      #Browse Resources in Shell
      
      Get-PSDrive  
      dir
      
    cd azure:
    
    cd cd 'Azure:/C+E DevRel CL Content RD US - mbender/'
    dir
    cd ./ResourceGroups/hub-spoke/
    dir
    cd ./Microsoft.Network/
    dir
    cd ~

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
    code get-DeployedVNet.ps1
    Copy in 
        Get-AzVirtualNetwork | format-table -Property Name,AddressSpace

    cls
    Dismount-CloudDrive
    1234$$dsfrdDD
