BeforeAll {
    $script:resourceGroupName = 'FunctionAppProvisioningTest'
    $script:location = 'westus'
    $script:resourceTemplateFile = 'provisioning.functionApp.bicep'
    $script:appName = "testFunctionApp$([guid]::NewGuid() | %{([string]$_).replace('-','').substring(22)})"
    write-verbose 'Provision Test Resource Group'
    write-verbose "./PtP/invoke.provision.resourceGroup.ps1 -location $script:location -resourceGroupName $script:ResourceGroupName -templateFile 'provisioning.resourceGroup.bicep' -workingDirectory '.' -dropResourceGroup $true -passThru $false"
    ./PtP/invoke.provision.resourceGroup.ps1 `
        -location $script:location `
        -resourceGroupName $script:ResourceGroupName `
        -templateFile 'provisioning.resourceGroup.bicep' `
        -workingDirectory '.' `
        -dropResourceGroup $true `
        -passThru $false
}
AfterAll {
    if ($(az group exists --name $script:resourceGroupName) -eq 'true') { 
        az group delete --resource-group $script:resourceGroupName --yes 
    }
}

Describe 'Provisioning function app tests' -tag 'provision' {
    Context ' Provision Resource Group' {
        It "  Provision function app when function app doesn't already exist" {
            write-verbose "resourceGroupName($script:resourceGroupName) location($script:location) resourceTemplateFile($script:resourceTemplateFile)"
            Get-ChildItem
            ./PtP/invoke.provision.functionApp.ps1 `
                -location $script:location `
                -resourceGroupName $script:ResourceGroupName `
                -templateFile $script:resourceTemplateFile `
                -workingDirectory '.' `
                -appName $script:appName `
                -passThru $true 
        }
    }
}

