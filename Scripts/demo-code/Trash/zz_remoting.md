# Azure VM Remoting Demo

This set of demos covers remoting into VMs in Azure.

## Create Environment

      $win = 'myWinVM1' 
      $lnx = 'mylinuxVM1'
      $rsg = 'myDemoRG'
      $cred = get-credential

new-AzResourceGroup -Name 'myDemoRG' -Location 'East US'


az vm create --resource-group 'myDemoRG' --name 'myWinVM2' --image Win2022AzureEditionCore --admin-username azureuser --ssh-key-value ~/.ssh/1682121252_9159791.pub --public-ip-address-dns-name myWinPublicIP2 --public-ip-sku standard


New-AzVm -ResourceGroupName 'myDemoRG' -Name 'myWinVM1' -Location 'East US' -VirtualNetworkName 'myVnet' -SubnetName 'mySubnet' -SecurityGroupName 'myNetworkSecurityGroup' -OpenPorts 80,3389 -publicIpAddressName 'myWinPublicIP'

### Remote management

Get-Command -Module PSCloudShellUtility

### Install Web-Server on VM

Invoke-AzVMRunCommand -ResourceGroupName 'myDemoRG' -VMName 'myWinVM1' -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server -IncludeManagementTools'

# Invoke-AzVMRunCommand -ResourceGroupName 'myDemoRG' -VMName 'myWinVM1' -CommandID 'RunPowerShellScript' -ScriptString "Get-Service -Name *WIN*"

Invoke-AzVMRunCommand -ResourceGroupName 'myDemoRG' -VMName 'myWinVM1' -CommandID 'RunPowerShellScript' -ScriptString "Get-Service -Name *WIN*"
Get-AzPublicIpAddress -Name 'myWinPublicIP' -ResourceGroupName myResourceGroup | select "IpAddress"

Enable-AzVMPSRemoting -name 'myWinVM1' -ResourceGroupName 'myDemoRG' -Protocol https -OsType Windows

Enter-AzVM -name 'myWinVM1' -ResourceGroupName 'myDemoRG' -localuser azureadmin
      >$hostname
      >get-service win*
      >exit

Get-AzPublicIpAddress -Name 'myWinPublicIP' -ResourceGroupName myResourceGroup | select "IpAddress"

Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -Name 'myVM' -CommandId 'RunShellScript' -ScriptString 'uname -a' -verbose

Get-AzPublicIpAddress -Name 'myLinuxPublicIP2' -ResourceGroupName myResourceGroup | select "IpAddress"

ssh -i ~/.ssh/1682174850 azureuser@172.190.15.84

### Linux

New-AzVm -ResourceGroupName 'myDemoRG' -Name 'myLinuxVM3' -Location 'East US'-Image Debian -size Standard_B2s -OpenPorts 80,22 -GenerateSshKey -SshKeyName mySSHKey2 -publicIpAddressName 'myLinuxPublicIP3'

#### Generate SSH Key
      ssh-keygen -t rsa -b 2048
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDINelhRUuzLWWbQJpih6e3ivL6jFxZ8L+mkI+pxVMR4LfvrB4M3l1YW0btozLSgipsDHDxeHC0k4It46NGYZpw0aJ0t7jVeWR8QctrZlsTaQow8xuKVNX0tlJcsgW6kzH9rd2uOt+XOOaXEMKaFO393dZB+0l4QuLTssbGnUwEXACIqNDcGfjSLxpGuaPmjgOF+YHG33ZzEp2BZVlTL8QfUT6VWuiIwo3ZE9EOgQReChNI476phbnieOlpQTdsxYRI3/ibMZK2CkRe3uxw7a/i9gXEiEH+19Ewo3sKeg2RJYfXvPOxLeuTs0ECTtWv6wkLZE2PoVywJ8K4vuG4AQ2X michael@cc-59fc45a5-54f86d8cd-fgnps
      #Verify Key
        ls -al ~/.ssh
        cat ~/.ssh/id_rsa.pub #List public key

#### Build Linux VM with key
az vm create --resource-group 'myDemoRG' --name 'myLinuxVM3' --image Ubuntu2204 --ssh-key-value ~/.ssh/ssh_key.pub --public-ip-address-dns-name myLinuxPublicIP3 --public-ip-sku standard

Enable-AzVMPSRemoting -Name 'myLinuxVM1' -ResourceGroupName 'myDemoRG' -Protocol ssh -OsType Linux

#### Linux VM - display current software and hardware information with uname

Invoke-AzVMCommand -Name 'myLinuxVM3' -ResourceGroupName 'myDemoRG' -ScriptBlock {uname -a} -UserName azureuser -KeyFilePath /home/michael/.ssh/1682174850

Get-AzPublicIpAddress -Name 'myLinuxPublicIP2' -ResourceGroupName myResourceGroup | select "IpAddress"

ssh -i ~/.ssh/1682174850 azureuser@172.190.15.84

Invoke-AzVMRunCommand -ResourceGroupName 'myDemoRG' -Name 'myLinuxVM01' -CommandId 'RunShellScript' -ScriptString 'sudo apt-get update && sudo apt-get install -y nginx'
     
      #Connect to linux vm
      ssh -i ~/.ssh/id_rsa azureuser@20.168.210.29

      #  for reference (https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-ssh-keys-detailed)

      #Enable Azure PSremotingcls
        Get-Command -module PScloudshellutility

      # Variables
      $win = 'myWinVM'
      $lnx = 'mylinuxVM'
      $rsg = 'myDemoRG'
      $cred = get-credential

### Remote with Windows

Enable-AzVMPSRemoting -Name $win -ResourceGroupName $rsg -Protocol https -OsType Windows

Enable-AzVMPSRemoting -Name $lnx -ResourceGroupName $rsg -Protocol ssh -OsType Linux

#### Run command on Windows VM using Invoke-Command

Invoke-AzVMCommand -Name $win -ResourceGroupName $rsg -ScriptBlock {Install-WindowsFeature -Name Web-Server -IncludeManagementTools} -Credential $cred



      # Linux VM
      Enable-AzVMPSRemoting -Name $lnx -ResourceGroupName $rsg -Protocol ssh -OsType Linux




 

      # Connect to VM with Remoting

      Enter-AzVM -name $win -ResourceGroupName $rsg -Credential $cred
      $hostname
      get-service win*
      exit

      #Disable Azure PSRemoting
      
      $win = 'myWinVM1' 
      $lnx = 'mylinuxVM1'
      $rsg = 'myDemoRG'
      $cred = get-credential

      Disable-AzVMPSRemoting -name 'mylinuxVM1' -ResourceGroupName 'myDemoRG'
      Disable-AzVMPSRemoting -name $lnx -ResourceGroupName $rsg
      Enter-AzVM -name 'mylinuxVM1' -ResourceGroupName $rsg -Credential $cred
      cls

