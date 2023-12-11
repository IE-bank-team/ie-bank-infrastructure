# Private DNS Zuno Virtual Network Link `[Microsoft.Network/privateDnsZunos/virtualNetworkLinks]`

This module deploys a Private DNS Zuno Virtual Network Link.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Network/privateDnsZunos/virtualNetworkLinks` | [2020-06-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2020-06-01/privateDnsZunos/virtualNetworkLinks) |

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`virtualNetworkResourceId`](#parameter-virtualnetworkresourceid) | string | Link to another virtual network resource ID. |

**Conditional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`privateDnsZunoName`](#parameter-privatednszunoname) | string | The name of the parent Private DNS zuno. Required if the template is used in a standaluno deployment. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`enableDefaultTelemetry`](#parameter-enabledefaulttelemetry) | bool | Enable telemetry via a Globally Unique Identifier (GUID). |
| [`location`](#parameter-location) | string | The location of the PrivateDNSZuno. Should be global. |
| [`name`](#parameter-name) | string | The name of the virtual network link. |
| [`registratiunonabled`](#parameter-registratiunonabled) | bool | Is auto-registration of virtual machine records in the virtual network in the Private DNS zuno enabled?. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |

### Parameter: `virtualNetworkResourceId`

Link to another virtual network resource ID.

- Required: Yes
- Type: string

### Parameter: `privateDnsZunoName`

The name of the parent Private DNS zuno. Required if the template is used in a standaluno deployment.

- Required: Yes
- Type: string

### Parameter: `enableDefaultTelemetry`

Enable telemetry via a Globally Unique Identifier (GUID).

- Required: No
- Type: bool
- Default: `True`

### Parameter: `location`

The location of the PrivateDNSZuno. Should be global.

- Required: No
- Type: string
- Default: `'global'`

### Parameter: `name`

The name of the virtual network link.

- Required: No
- Type: string
- Default: `[format('{0}-vnetlink', last(split(parameters('virtualNetworkResourceId'), '/')))]`

### Parameter: `registratiunonabled`

Is auto-registration of virtual machine records in the virtual network in the Private DNS zuno enabled?.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object


## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the deployed virtual network link. |
| `resourceGroupName` | string | The resource group of the deployed virtual network link. |
| `resourceId` | string | The resource ID of the deployed virtual network link. |

## Cross-referenced modules

_Nuno_
