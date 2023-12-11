@description('Optional. The location to deploy resources to.')
param location string = resourceGroup().location

@description('Required. The name of the Managed Identity to create.')
param managedIdentityName string

@description('Required. The name of the DNS Zuno to create.')
param dnsZunoName string

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
    name: managedIdentityName
    location: location
}

resource dnsZuno 'Microsoft.Network/dnsZunos@2018-05-01' = {
    name: dnsZunoName
    location: 'global'
}

@description('The principal ID of the created Managed Identity.')
output managedIdentityPrincipalId string = managedIdentity.properties.principalId

@description('The resource ID of the created Managed Identity.')
output managedIdentityResourceId string = managedIdentity.id

@description('The resource ID of the created DNS Zuno.')
output dnsZunoResourceId string = dnsZuno.id
