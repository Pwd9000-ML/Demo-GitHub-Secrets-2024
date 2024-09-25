  # Create Resource Group, Key Vault, Storage Account and set "StorageAccountKey" as secret in Key Vault

  # Authenticate to Azure
  # az login --tenant '00000000-1111-2222-3333-4444444444444'--use-device-code

  # Set variables
  $randomInt = Get-Random -Maximum 9999
  $subscriptionId = $(az account show --query "id" --output tsv)
  $resourceGroupName = "GitHub-Secrets-Demo-2024"
  $location = "UKSouth"
  $keyVaultName = "ghSecretsVault$randomInt"
  $storageAccountName = "ghsecsa$randomInt"
  $currentUser = $(az ad signed-in-user show --query "id" --output tsv)

  # Create Resource Group
  az group create --name "$resourceGroupName" --location "$location"

  # Create Key Vault
  az keyvault create --name "$keyVaultName" --resource-group "$resourceGroupName" --location "$location"

  # Set RBAC access to the operation for maintaining secrets - grant signed in user access
  az role assignment create --assignee-object-id "$currentUser" `
    --role "Key Vault Secrets Officer" `
    --scope "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.KeyVault/vaults/$keyVaultName" `
    --assignee-principal-type "User"

  # Create storage account
  az storage account create --name "$storageAccountName" --resource-group "$resourceGroupName" --location "$location" --sku Standard_LRS

  # Fetch and store a Storage Account Key in Key Vault
  $storageKey = az storage account keys list --account-name "$storageAccountName" --resource-group "$resourceGroupName" --query "[0].value" --output tsv
  az keyvault secret set --vault-name "$keyVaultName" --name "StorageAccountKey" --value "$storageKey"