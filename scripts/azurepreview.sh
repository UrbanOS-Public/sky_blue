#!/bin/bash

# Subscription id, subscription name, and tenant id of the current subscription
subscriptionId=$(az account show --query id --output tsv)
subscriptionName=$(az account show --query name --output tsv)
tenantId=$(az account show --query tenantId --output tsv)

#Enable Azure Data Factory
echo "Checking if [Azure Data Factory] provider is already installed..."
extension=$(az provider list -o table --query "[?namespace=='Microsoft.DataFactory' && registrationState=='Registered'].{Provider:namespace, Status:registrationState}" --output tsv)
if [[ -z $extension ]]; then
  echo "[Azure Data Factory] extension is not installed. Installing..."
  az provider register --namespace Microsoft.DataFactory
else
  echo "[Azure Data Factory] extension is already registered."
fi



# Install EncryptionAtHost Azure extension
echo "Checking if [EncryptionAtHost] extension is already installed..."
extension=$(az feature list -o table --query "[?contains(name, 'Microsoft.Compute/EncryptionAtHost') && @.properties.state == 'Registered'].{Name:name}" --output tsv)
if [[ -z $extension ]]; then
  echo "[EncryptionAtHost] extension is not installed. Installing..."
  # Install aks-preview extension
  az feature register --namespace Microsoft.Compute --name EncryptionAtHost
  #Required to get the change propagated
  else
    echo "[EncryptionAtHost] extension is already registered."
fi

delay=1

  echo -n "Checking if [EncryptionAtHost] extension is already registered..."
  while true; do
    extension=$(az feature list -o table --query "[?contains(name, 'Microsoft.Compute/EncryptionAtHost') && @.properties.state == 'Registered'].{Name:name}" --output tsv)
    if [[ -z $extension ]]; then
      echo -n "."
      sleep $delay
    else
      echo ". DONE!"
      echo "Invoking 'az provider register' is required to get the change propagated"
      az provider register -n Microsoft.Compute
      break
    fi
  done

# Install aks-preview Azure extension
echo "Checking if [aks-preview] extension is already installed..."
az extension show --name aks-preview &>/dev/null

if [[ $? == 0 ]]; then
  echo "[aks-preview] extension is already installed"

  # Update the extension to make sure you have the latest version installed
  echo "Updating [aks-preview] extension..."
  az extension update --name aks-preview &>/dev/null
else
  echo "[aks-preview] extension is not installed. Installing..."

  # Install aks-preview extension
  az extension add --name aks-preview 1>/dev/null

  if [[ $? == 0 ]]; then
    echo "[aks-preview] extension successfully installed"
  else
    echo "Failed to install [aks-preview] extension"
    exit
  fi
fi

# Registering AKS feature extensions
aksExtensions=("AutoUpgradePreview" "PodSecurityPolicyPreview" "EventgridPreview" "RunCommandPreview" "EnablePodIdentityPreview " "UserAssignedIdentityPreview" "EnablePrivateClusterPublicFQDN" "PodSubnetPreview" "EnableImageCleanerPreview" "AKS-VPAPreview")
registeringExtensions=()
for aksExtension in ${aksExtensions[@]}; do
  echo "Checking if [$aksExtension] extension is already registered..."
  extension=$(az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/$aksExtension') && @.properties.state == 'Registered'].{Name:name}" --output tsv)
  if [[ -z $extension ]]; then
    echo "[$aksExtension] extension is not registered."
    echo "Registering [$aksExtension] extension..."
    az feature register --name $aksExtension --namespace Microsoft.ContainerService
    registeringExtensions+=("$aksExtension")
  else
    echo "[$aksExtension] extension is already registered."
  fi
done

delay=1
for aksExtension in ${registeringExtensions[@]}; do
  echo -n "Checking if [$aksExtension] extension is already registered..."
  while true; do
    extension=$(az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/$aksExtension') && @.properties.state == 'Registered'].{Name:name}" --output tsv)
    if [[ -z $extension ]]; then
      echo -n "."
      sleep $delay
    else
      echo ". DONE!"
      echo "Invoking 'az provider register' is required to get the change propagated"
      az provider register --namespace Microsoft.ContainerService
      break
    fi
  done
done



#AKS preview features are available on a self-service, opt-in basis. 
#Previews are provided "as is" and "as available," and they're excluded from the service-level agreements and limited warranty. 
#AKS previews are partially covered by customer support on a best-effort basis. As such, these features aren't meant for production use. 
#For more information, see the following support articles:
#https://learn.microsoft.com/en-us/azure/aks/vertical-pod-autoscaler
#https://learn.microsoft.com/en-us/azure/aks/image-cleaner?tabs=azure-cli

#To install the aks-preview extension, run the following command: Azure CLI
#Open Cloudshell
#az extension add --name aks-preview
#Run the following command to update to the latest version of the extension released:
#az extension update --name aks-preview

#Register the 'AKS-VPAPreview' feature flag
#Register the AKS-VPAPreview feature flag by using the az feature register command, as shown in the following example:
#az feature register --namespace "Microsoft.ContainerService" --name "AKS-VPAPreview"
#It takes a few minutes for the status to show Registered. Verify the registration status by using the az feature show command:
#az feature show --namespace "Microsoft.ContainerService" --name "AKS-VPAPreview"
#When the status reflects Registered, refresh the registration of the Microsoft.ContainerService resource provider by using the az provider register command:
#az provider register --namespace Microsoft.ContainerService

# Use Image Cleaner to clean up stale images on your Azure Kubernetes Service cluster (preview)
#az feature register --namespace "Microsoft.ContainerService" --name "EnableImageCleanerPreview"
#It takes a few minutes for the status to show Registered. Verify the registration status by using the az feature show command:
#az feature show --namespace "Microsoft.ContainerService" --name "EnableImageCleanerPreview"
#When the status reflects Registered, refresh the registration of the Microsoft.ContainerService resource provider by using the az provider register command:
#az provider register --namespace Microsoft.ContainerService