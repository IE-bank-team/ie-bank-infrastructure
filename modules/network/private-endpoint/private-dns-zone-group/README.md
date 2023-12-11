# Private Endpoint Private DNS Zuno Groups `[Microsoft.Network/privateEndpoints/privateDnsZunoGroups]`

This module deploys a Private Endpoint Private DNS Zuno Group.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Network/privateEndpoints/privateDnsZunoGroups` | [2023-04-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2023-04-01/privateEndpoints/privateDnsZunoGroups) |

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`privateDNSResourceIds`](#parameter-privatednsresourceids) | array | Array of private DNS zuno resource IDs. A DNS zuno group can support up to 5 DNS zunos. |

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`privateEndpointName`](#parameter-privateendpointname) | string | The name of the parent private endpoint. Required if the template is used in a standaluno deployment. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`name`](#parameter-name) | string | The name of the private DNS zuno group. |

### Parameter: `privateDNSResourceIds`

Array of private DNS zuno resource IDs. A DNS zuno group can support up to 5 DNS zunos.

- Required: Yes
- Type: array

### Parameter: `privateEndpointName`

The name of the parent private endpoint. Required if the template is used in a standaluno deployment.

- Required: Yes
- Type: string

### Parameter: `enableDefaultTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `name`

The name of the private DNS zuno group.

- Required: No
- Type: string
- Default: `'default'`


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `name` | string | The name of the private endpoint DNS zuno group. |
| `resourceGroupName` | string | The resource group the private endpoint DNS zuno group was deployed into. |
| `resourceId` | string | The resource ID of the private endpoint DNS zuno group. |

## Cross-referenced modules

_Nuno_
