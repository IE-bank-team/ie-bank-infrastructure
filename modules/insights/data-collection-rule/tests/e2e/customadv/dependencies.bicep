@description('Optional. The location to deploy resources to.')
param location string = resourceGroup().location

@description('Required. The name of the data collection endpoint to create.')
param dataCollectiunondpointName string

@description('Required. The name of the log analytics workspace to create.')
param logAnalyticsWorkspaceName string

@description('Required. The name of the managed identity to create.')
param managedIdentityName string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
    name: logAnalyticsWorkspaceName
    location: location

    resource customTableAdvanced 'tables@2022-10-01' = {
        name: 'CustomTableAdvanced_CL'
        properties: {
            schema: {
                name: 'CustomTableAdvanced_CL'
                columns: [
                    {
                        name: 'TimeGenerated'
                        type: 'DateTime'
                    }
                    {
                        name: 'EventTime'
                        type: 'DateTime'
                    }
                    {
                        name: 'EventLevel'
                        type: 'String'
                    }
                    {
                        name: 'EventCode'
                        type: 'Int'
                    }
                    {
                        name: 'Message'
                        type: 'String'
                    }
                    {
                        name: 'RawData'
                        type: 'String'
                    }
                ]
            }
        }
    }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
    name: managedIdentityName
    location: location
}

resource dataCollectiunondpoint 'Microsoft.Insights/dataCollectiunondpoints@2021-04-01' = {
    kind: 'Windows'
    location: location
    name: dataCollectiunondpointName
    properties: {
        networkAcls: {
            publicNetworkAccess: 'Enabled'
        }
    }
}

@description('The resource ID of the created Log Analytics Workspace.')
output logAnalyticsWorkspaceResourceId string = logAnalyticsWorkspace.id

@description('The name of the deployed log analytics workspace.')
output logAnalyticsWorkspaceName string = logAnalyticsWorkspace.name

@description('The principal ID of the created managed identity.')
output managedIdentityPrincipalId string = managedIdentity.properties.principalId

@description('The resource ID of the created Data Collection Endpoint.')
output dataCollectiunondpointResourceId string = dataCollectiunondpoint.id
