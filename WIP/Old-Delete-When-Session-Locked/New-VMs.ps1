$RGName = 'mibenderdemo'
$location = 'westus'

$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name "mibenderSubnet" -AddressPrefix 192.168.1.0/24
$vnet = New-AzVirtualNetwork -ResourceGroupName $RGName -Location $location -Name 'mibenderVNET' -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig
$pip = New-AzPublicIpAddress -ResourceGroupName $RGName -Location $location -AllocationMethod Static -IdleTimeoutInMinutes 4 -Name "mibenderPublicDNS$(Get-Random)"

$nsgRuleSSH = New-AzNetworkSecurityRuleConfig -Name "mibenderNetworkSecurityGroupRuleSSH" -Protocol "TCP" -Direction "Inbound" -Priority 1000 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 22 -Access 'Allow'
$nsgRuleWeb = New-AzNetworkSecurityRuleConfig -Name "mibenderNetworkSecurityGroupRuleWWW" -Protocol "TCP" -Direction "Inbound" -Priority 1001 -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80 -Access 'Allow'
$nsg = New-AzNetworkSecurityGroup -ResourceGroupName $RGName -Location $location -Name 'mibenderNSG' -SecurityRules $nsgRuleSSH,$nsgRuleWeb

$nic = New-AzNetworkInterface -Name "mibenderNic" -ResourceGroupName $RGName -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

$vmConfig = New-AzVMConfig -VMName 'DemoLin' -VMSize "Standard_D1" | Set-AzureRMVMOperatingSystem -Linux -ComputerName 'DemoLin' -Credential $cred -DisablePasswordAuthentication | Set-AzureRMVMSourceImage -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "16.04-LTS" -Version "latest" | Add-AzureRMVMNetworkInterface -Id $nic.Id

$sshPublicKey = Get-Content "/home/michael/.ssh/id_rsa.pub"
Add-AzVMSshPublicKey -VM $vmConfig -KeyData $sshPublicKey -Path "/home/michael/.ssh/authorized_keys"


New-AzVM -ResourceGroupName $RGName -Location westus -VM $vmConfig

# #################

$cred = Get-Credential
$vmParams = @{
  ResourceGroupName = 'mibenderDemo'
  Name = 'DemoWin'
  Location = 'eastus'
  ImageName = 'Win2016Datacenter'
  Credential = $cred
  OpenPorts = 3389
}
New-AzVM @vmParams

