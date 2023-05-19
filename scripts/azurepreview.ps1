#AKS preview features are available on a self-service, opt-in basis. 
#Previews are provided "as is" and "as available," and they're excluded from the service-level agreements and limited warranty. 
#AKS previews are partially covered by customer support on a best-effort basis. As such, these features aren't meant for production use. 
#For more information, see the following support articles:
#https://learn.microsoft.com/en-us/azure/aks/vertical-pod-autoscaler
#https://learn.microsoft.com/en-us/azure/aks/image-cleaner?tabs=azure-cli

#To install the aks-preview extension, run the following command: Azure CLI
#Open Cloudshell
az extension add --name aks-preview
#Run the following command to update to the latest version of the extension released:
az extension update --name aks-preview

#Register the 'AKS-VPAPreview' feature flag
#Register the AKS-VPAPreview feature flag by using the az feature register command, as shown in the following example:
az feature register --namespace "Microsoft.ContainerService" --name "AKS-VPAPreview"
#It takes a few minutes for the status to show Registered. Verify the registration status by using the az feature show command:
az feature show --namespace "Microsoft.ContainerService" --name "AKS-VPAPreview"
#When the status reflects Registered, refresh the registration of the Microsoft.ContainerService resource provider by using the az provider register command:
az provider register --namespace Microsoft.ContainerService

# Use Image Cleaner to clean up stale images on your Azure Kubernetes Service cluster (preview)
az feature register --namespace "Microsoft.ContainerService" --name "EnableImageCleanerPreview"
#It takes a few minutes for the status to show Registered. Verify the registration status by using the az feature show command:
az feature show --namespace "Microsoft.ContainerService" --name "EnableImageCleanerPreview"
#When the status reflects Registered, refresh the registration of the Microsoft.ContainerService resource provider by using the az provider register command:
az provider register --namespace Microsoft.ContainerService