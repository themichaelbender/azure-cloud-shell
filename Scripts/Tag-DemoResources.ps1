function Tag-DemoResources {
    [CmdletBinding()]
    param (
        [string[]]$ResourceGroupName
    )
    
    begin {
        $resources = get-azResource -ResourceGroupName $ResourceGroupName
    }
    
    process {
        foreach ($resource in $resources) {
            $ResourceID = $resource.id
            Update-AzTag -ResourceID $ResourceID -Tag @{Event = 'PowerShell-Summit-2023'} -Operation Merge
        }
    }
    
    end {
        
    }
}