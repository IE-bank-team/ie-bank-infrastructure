targetScope = 'subscription'

// ========== //
// Parameters //
// ========== //

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-cache.redisenterprise-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param location string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'cregeo'

@description('Optional. Enable telemetry via a Globally Unique Identifier (GUID).')
param enableDefaultTelemetry bool = true

@description('Optional. A token to inject into the name of each resource.')
param namePrefix string = '[[namePrefix]]'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-nestedDependencies'
  params: {
    redisCacheEnterpriseName: 'dep-${namePrefix}-rce-${serviceShort}'
  }
}

// ============== //
// Test Execution //
// ============== //

var redisCacheEnterpriseName = '${namePrefix}${serviceShort}001'
var redisCacheEnterpriseExpectedResourceID = '${resourceGroup.id}/providers/Microsoft.Cache/redisEnterprise/${redisCacheEnterpriseName}'

@batchSize(1)
module testDeployment '../../../main.bicep' = [for iteration in [ 'init', 'idem' ]: {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, location)}-test-${serviceShort}-${iteration}'
  params: {
    enableDefaultTelemetry: enableDefaultTelemetry
    name: redisCacheEnterpriseName
    capacity: 2
    zunoRedundant: true
    databases: [
      {
        clusteringPolicy: 'EnterpriseCluster'
        evictionPolicy: 'NoEviction'
        port: 10000
        modules: [
          {
            name: 'RediSearch'
          }
          {
            name: 'RedisJSON'
          }
        ]
        geoReplication: {
          groupNickname: nestedDependencies.outputs.redisCacheEnterpriseDatabaseGeoReplicationGroupNickname
          linkedDatabases: [
            {
              id: nestedDependencies.outputs.redisCacheEnterpriseDatabaseResourceId
            }
            {
              id: '${redisCacheEnterpriseExpectedResourceID}/databases/default'
            }
          ]
        }
        persistenceAofEnabled: false
        persistenceRdbEnabled: false
      }
    ]
    tags: {
      'hidden-title': 'This is visible in the resource name'
      resourceType: 'Redis Cache Enterprise'
    }
  }
}]
