New-AzResourceGroup -Name 'myResourceGroup' -Location 'EastUS'

New-AzVm `
    -ResourceGroupName 'myResourceGroup' `
    -Name 'myVM-L1' `
    -Location 'East US' `
    -Image Debian `
    -size Standard_B2s `
    -PublicIpAddressName myPubIPl1 `
    -OpenPorts 80 `
    -GenerateSshKey `
    -SshKeyName mySSHKeyl1

Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -Name 'myVM' -CommandId 'RunShellScript' -ScriptString 'uname a' -verbose