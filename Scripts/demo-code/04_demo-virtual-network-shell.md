## Deploy Cloud Shell into an Azure virtual network

Reference: https://learn.microsoft.com/en-us/azure/cloud-shell/private-vnet?wt.mc_id=aznetdocs_pssummit_inperson_cnl_csainfra

## Register the resource provider

Get-AzResourceProvider -ProviderNamespace Microsoft.ContainerInstance | select ResourceTypes,RegistrationState

Register-AzResourceProvider -ProviderNamespace Microsoft.ContainerInstance

## Create Resource Group

$RG = New-AzResourceGroup -Name rg-summit-prod-westus -Location westus

## Create Virtual network

$virtualNetwork = New-AzVirtualNetwork -Name 'vnet-summit-prod-westus-001' -ResourceGroupName 'rg-summit-prod-westus' -Location 'westus' -AddressPrefix '10.0.0.0/16'

Add-AzVirtualNetworkSubnetConfig -Name 'default' -VirtualNetwork $virtualNetwork -AddressPrefix '10.0.0.0/24'

$virtualNetwork | Set-AzVirtualNetwork

##Deploy Template

VNet ARM Template https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/cloud-shell-vnet/

### Azure Container Instance Service Principal 
    Get-AzADServicePrincipal -DisplayNameBeginsWith 'Azure Container Instance'

VNet Storage ARM Template https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/cloud-shell-vnet-storage/

## Requirements

## Open Firewall for Relay

## mount Cloud Shell storage to VNet

## Upload to Blob

### Get Blob
$storage = Get-AzStorageAccount -ResourceGroupName 'myDemoRG' -Name 'sasummitstorage001'

$context = $storage.Context

$ContainerName = "blob"

Get-AzStorageBlob -Container "blob" -Context $context

## Upload

$Blob1HT = @{
  File             = '.\image001.jpg'
  Container        = "blob"
  Blob             = "Image001.jpg"
  Context          = $Context
  StandardBlobTier = 'Hot'
}
Set-AzStorageBlobContent @Blob1HT

### Download

$DLBlob1HT = @{
  Blob        = 'introduction-to-azure-cloud-shell.svg'
  Container   = $ContainerName
  Destination = './clouddrive/downloads'
  Context     = $Context
}
Get-AzStorageBlobContent @DLBlob1HT

get-childitem -Path ./clouddrive/downloads/