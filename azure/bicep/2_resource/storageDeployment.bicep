@description('Storage account name')
param storageAccountName string = 'sademo${uniqueString(resourceGroup().id)}'

@description('Storage account location')
param deplLocation string = resourceGroup().location

@description('Tags')
param tags object = {}

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

// Create basic storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  tags: tags
  location: deplLocation
  kind: 'StorageV2'
  sku: {
    name: storageAccountSku
  }
}

// Create blob service
resource storageAccountBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageAccount
}

// Create container
resource storageAccountContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: 'images'
  parent: storageAccountBlobServices
}
