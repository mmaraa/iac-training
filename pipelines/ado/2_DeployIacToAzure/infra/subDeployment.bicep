targetScope = 'subscription'

@description('Resource group name')
param rgName string = 'rg-ado-pipeline-example2-dev'

@description('Deployment location')
param deplLocation string = 'swedencentral'

@description('Tags')
param tags object = {
  application: 'MyApp'
}

resource myNewRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  tags: tags
  location: deplLocation
}

module storage 'modules/storageAccount.bicep' = {
  name: guid(rgName)
  scope: resourceGroup(rgName)
  params: {
    deplLocation: myNewRg.location
    tags: tags
  }
}
