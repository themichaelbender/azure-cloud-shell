# Azure VM Remoting Demo

This set of demos covers remoting into VMs in Azure.

### Remote management

Get-Command -Module PSCloudShellUtility

### Install Web-Server on VM
$myvm = 'myWinVM1'
$
Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -VMName 'myVM2' -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server -IncludeManagementTools' -AsJob

Get-AzPublicIpAddress -Name 'myVM2-ip' -ResourceGroupName myResourceGroup | select "IpAddress"

Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -Name 'myVM' -CommandId 'RunShellScript' -ScriptString 'uname -a' -verbose