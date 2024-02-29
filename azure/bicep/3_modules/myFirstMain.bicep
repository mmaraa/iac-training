targetScope = 'subscription'

@description('Resource group name')
param rgName string = 'rg-example3-bicep'

@description('Deployment location')
param deplLocation string = 'swedencentral'

@description('Storage account name')
param storageAccountName string = 'sademo${uniqueString(subscription().subscriptionId)}'

@description('Storage account SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param storageAccountSku string = 'Standard_LRS'

@description('Tags')
param tags object = {}

module rg '../1_subDeployment/subDeployment.bicep' = {
  name: 'subDeployment'
  params: {
    rgName: rgName
    deplLocation: deplLocation
    tags: tags
  }
}

module storageAccount '../2_resource/storageDeployment.bicep' = {
  name: 'storageDeployment'
  scope: resourceGroup(rgName)
  params: {
    deplLocation: deplLocation
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}
