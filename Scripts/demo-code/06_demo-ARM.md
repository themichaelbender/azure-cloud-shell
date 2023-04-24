    # Deployment of ARM Templates

    # Reference Article : https://learn.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke?tabs=powershell?wt.mc_id=aznetdocs_pssummit_inperson_cnl_csainfra

    # Run from Cloud Shell on doc


    get-azResource -ResourceGroupName 'hub-spoke' | format-table 

    remove-azResourceGroup -AsJob -Force -Name hub-spoke

    # Deploy a Secure hybrid network from ARM Template
    # Reference - https://learn.microsoft.com/en-us/samples/mspnp/samples/secure-hybrid-network/

    New-AzResourceGroup -Name 'cloudshell-demo-ARMDeploy-ps' -location 'eastUS'

New-AzDeployment -TemplateUri https://raw.githubusercontent.com/mspnp/samples/master/solutions/secure-hybrid-network/azuredeploy.json -Location eastus -verbose   

get-AzResource -ResourceGroupName "site-to-site-azure-network" | Format-Table
Az deployment sub create --template-uri https://raw.githubusercontent.com/mspnp/samples/master/solutions/secure-hybrid-network/azuredeploy.json --location eastus

    get-azResource -ResourceGroupName $RG | Format-Table
    
    cls