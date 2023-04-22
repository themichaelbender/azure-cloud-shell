# Azure VM Remoting Demo

This set of demos covers remoting into VMs in Azure.

### Remote management

Get-Command -Module PSCloudShellUtility

### Install Web-Server on VM
$myvm = 'myWinVM1'
$
Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -VMName 'myVM2' -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server -IncludeManagementTools' -AsJob

Get-AzPublicIpAddress -Name 'myVM2-ip' -ResourceGroupName myResourceGroup | select "IpAddress"

Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -VMName 'myWinVM1' -CommandID 'RunPowerShellScript' -ScriptString "Get-Service -Name *WIN*"

Enable-AzVMPSRemoting -name 'myWinVM1' -ResourceGroupName 'myResourceGroup' -Protocol https,ssh -OsType Windows

Enter-AzVM -name 'myVM2' -ResourceGroupName 'myResourceGroup' -localuser azureuser
      >$hostname
      >get-service win*
      >exit

Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -Name 'myVM' -CommandId 'RunShellScript' -ScriptString 'uname -a' -verbose

Get-AzPublicIpAddress -Name 'myPubIP' -ResourceGroupName myResourceGroup | select "IpAddress"

ssh -i ~/.ssh/1682174850 azureuser@192.168.1.4