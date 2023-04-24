## Deploy Cloud Shell into an Azure virtual network

Reference: https://learn.microsoft.com/en-us/azure/cloud-shell/private-vnet?wt.mc_id=aznetdocs_pssummit_inperson_cnl_csainfra

## Register the resource provider

Get-AzResourceProvider -ProviderNamespace Microsoft.ContainerInstance | select ResourceTypes,RegistrationState

Register-AzResourceProvider -ProviderNamespace Microsoft.ContainerInstance

## Create Resource Group

```AzurePowerShell
$RG = New-AzResourceGroup -Name 'myRelayRG' -Location 'westus'
```

## Create Virtual network

```powershell
$virtualNetwork = New-AzVirtualNetwork -Name 'myRelayVNet' -ResourceGroupName 'myRelayRG' -Location 'westus' -AddressPrefix '10.0.0.0/16'

Add-AzVirtualNetworkSubnetConfig -Name 'default' -VirtualNetwork $virtualNetwork -AddressPrefix '10.0.0.0/24'

$virtualNetwork | Set-AzVirtualNetwork
```

## Azure Container Instance Service Principal

```powershell
Get-AzADServicePrincipal -DisplayNameBeginsWith 'Azure Container Instance'
```
    

##Deploy Template

VNet ARM Template https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/cloud-shell-vnet/



VNet Storage ARM Template https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/cloud-shell-vnet-storage/

## Requirements

## Open Firewall for Relay on Storage Account

## mount Cloud Shell storage to VNet
### Get Blob

$storage = Get-AzStorageAccount -ResourceGroupName 'myRelayRG' -Name 'sacloudshellpsdemo001'

$context = $storage.Context

$ContainerName = "demoblob"

Get-AzStorageBlob -Container "demoblob" -Context $context

## Upload to Blob

$Blob1HT = @{
  File             = '.\image001.jpg'
  Container        = "demoblob"
  Blob             = "Image001.jpg"
  Context          = $Context
  StandardBlobTier = 'Hot'
}
Set-AzStorageBlobContent @Blob1HT

### Download

$DLBlob1HT = @{
  Blob        = 'introduction-to-azure-cloud-shell.svg'
  Container   = $ContainerName
  Context     = $Context
}
Get-AzStorageBlobContent @DLBlob1HT

New-AzVm -ResourceGroupName 'myRelayRG' -Name 'myWinVM1' -Location 'West US' -VirtualNetworkName 'myRelayVNet' -SubnetName 'default' -SecurityGroupName 'myNetworkSecurityGroup' -OpenPorts 80,3389 -publicIpAddressName 'myWinPublicIP'

Invoke-AzVMRunCommand -ResourceGroupName 'myRelayRG' -VMName 'myWinVM1' -CommandId 'RunPowerShellScript' -ScriptString 'get-service *WIN*'

Get-AzPublicIpAddress -Name 'myWinVM1-ip' -ResourceGroupName 'myRelayRG' | select "IpAddress"