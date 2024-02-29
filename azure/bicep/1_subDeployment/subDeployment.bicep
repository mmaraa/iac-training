targetScope = 'subscription'

@description('Resource group name')
param rgName string = 'rg-example1-bicep'

@description('Deployment location')
param deplLocation string

@description('Tags')
param tags object = {
  application: 'MyApp'
}

resource myNewRg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  tags: tags
  location: deplLocation
}

output myRgId string = myNewRg.id
