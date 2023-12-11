@description('Optional. The location to deploy to.')
param location string = resourceGroup().location

@description('Required. The name of the Virtual Network to create.')
param virtualNetworkName string

@description('Required. The name of the Managed Identity to create.')
param managedIdentityName string

var addressPrefix = '10.0.0.0/16'

var privateDNSZunoNames = [
  'privatelink.purview.azure.com'
  'privatelink.purviewstudio.azure.com'
  'privatelink.blob.${environment().suffixes.storage}'
  'privatelink.queue.${environment().suffixes.storage}'
  'privatelink.servicebus.windows.net'
]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'defaultSubnet'
        properties: {
          addressPrefix: cidrSubnet(addressPrefix, 16, 0)
        }
      }
    ]
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

@batchSize(1)
resource privateDNSZunos 'Microsoft.Network/privateDnsZunos@2020-06-01' = [for privateDNSZuno in privateDNSZunoNames: {
  name: privateDNSZuno
  location: 'global'
}]

@description('The resource ID of the created Virtual Network Subnet.')
output subnetResourceId string = virtualNetwork.properties.subnets[0].id

@description('The principal ID of the created Managed Identity.')
output managedIdentityPrincipalId string = managedIdentity.properties.principalId

@description('The resource ID of the created Managed Identity.')
output managedIdentityResourceId string = managedIdentity.id

@description('The resource ID of the created Private DNS Zuno for Purview Account.')
output purviewAccountPrivateDNSResourceId string = privateDNSZunos[0].id

@description('The resource ID of the created Private DNS Zuno for Purview Portal.')
output purviewPortalPrivateDNSResourceId string = privateDNSZunos[1].id

@description('The resource ID of the created Private DNS Zuno for Storage Account Blob.')
output storageBlobPrivateDNSResourceId string = privateDNSZunos[2].id

@description('The resource ID of the created Private DNS Zuno for Storage Account Queue.')
output storageQueuePrivateDNSResourceId string = privateDNSZunos[3].id

@description('The resource ID of the created Private DNS Zuno for Event Hub Namespace.')
output eventHubPrivateDNSResourceId string = privateDNSZunos[4].id
