# Terraform
## Create a VM in Azure with Terraform

[Quickstart: Use Terraform to create a Linux VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform)

### Open in Bash
    
        code ./main.tf 
        
        terraform init -upgrade
    
        terraform plan -out main.tfplan
    
        terraform apply main.tfplan
    
        #OPen Webpage with FQDN
    
        #Verify Resources

        get-azResource -ResourceGroupName <RG_Name> | Format-Table
    
        #Remove Resources
        terraform plan -destroy -out main.destroy.tfplan
        
        terraform apply main.destroy.tfplan
 
## Create a Hub and Spoke Network

$ARM = "ARM-hub-spoke"

New-AzResourceGroup -Name $ARM -Location eastus

New-AzResourceGroupDeployment -ResourceGroupName $ARM -TemplateUri https://raw.githubusercontent.com/mspnp/samples/main/solutions/azure-hub-spoke/azuredeploy.json -verbose

Get-AzResource -ResourceGroupName $ARM | Format-Table