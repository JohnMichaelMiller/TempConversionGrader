
BeforeDiscovery {
    $script:rgName = 'test-rg' 
}
BeforeAll {
    $script:rgName = 'test-rg' 
    $script:location = 'westus'
    $script:resourceTemplateFile = 'provisioning.resourceGroup.bicep'
    if ($(az group exists --name $script:rgName) -eq 'true') {
        write-verbose "Deleting existing test resource group $($script:rgName)" 
        az group delete --resource-group $script:rgName --yes 
    }
}

AfterAll {
    if ($(az group exists --name $script:rgName) -eq 'true') { 
        az group delete --resource-group $script:rgName --yes 
    }
}

Describe 'Provisioning resource group tests' -tag 'provision' {
    Context " Provision Resource Group" {
        It "  Provision resource group when resource group $script:rgName doesn't already exist" {
            write-verbose "rgName($script:rgName) location($script:location) resourceTemplateFile($script:resourceTemplateFile)"
            ./PtP/invoke.provision.resourceGroup.ps1 `
                -location $script:location `
                -resourceGroupName $script:rgName `
                -templateFile $script:resourceTemplateFile `
                -workingDirectory '.' `
                -dropResourceGroup $false `
                -passThru $true 
            $(az group exists --name $script:rgName) | Should -Be 'true'
            write-verbose "az group exists --name $script:rgName"
        }
        It "  Provision resource group $script:rgName when resource group $script:rgName already exists" {
            write-verbose "rgName($script:rgName) location($script:location) resourceTemplateFile($script:resourceTemplateFile)"
            ./PtP/invoke.provision.resourceGroup.ps1 `
                -location $script:location `
                -resourceGroupName $script:rgName `
                -templateFile $script:resourceTemplateFile `
                -workingDirectory '.' `
                -dropResourceGroup $false `
                -passThru $true
            $(az group exists --name $script:rgName) | Should -Be 'true'
            write-verbose "az group exists --name $script:rgName"
        }
        It "  Drop Resource group $script:rgName and then provision resource group $script:rgName" {
            write-verbose "resourceGroupName($script:rgName) location($script:location) resourceTemplateFile($script:resourceTemplateFile)"
            ./PtP/invoke.provision.resourceGroup.ps1 `
                -location $script:location `
                -resourceGroupName $script:rgName `
                -templateFile $script:resourceTemplateFile `
                -workingDirectory '.' `
                -dropResourceGroup $false `
                -passThru $true
            $(az group exists --name $script:rgName) | Should -Be 'true'
            write-verbose "az group exists --name $script:rgName"
        }
        It "  Drop Resource group $script:rgName and then provision resource group $script:rgName when resource group $script:rgName doesn't exist" {
            write-verbose "resourceGroupName($script:rgName) location($script:location) resourceTemplateFile($script:resourceTemplateFile)"
            if ($(az group exists --name $script:rgName) -eq 'true') { 
                write-verbose "az group delete --resource-group $script:rgName --yes "
                az group delete --resource-group $script:rgName --yes 
            }
            ./PtP/invoke.provision.resourceGroup.ps1 `
                -location $script:location `
                -resourceGroupName $script:rgName `
                -templateFile $script:resourceTemplateFile `
                -workingDirectory '.' `
                -dropResourceGroup $false `
                -passThru $true
            $(az group exists --name $script:rgName) | Should -Be 'true'
            write-verbose "az group exists --name $script:rgName"
        }
    }
}