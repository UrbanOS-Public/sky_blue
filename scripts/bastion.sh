#az login
#az account set --subscription "962dc63d-463c-48c1-a588-20b22134bbd1"

#az extension add --upgrade -n bastion
#az extension add --upgrade -n ssh

az network bastion ssh --name "snap-urbanos-spoke-dev-eus" --resource-group "rg-urbanos-spoke-dev-eus" --target-resource-id "/subscriptions/962dc63d-463c-48c1-a588-20b22134bbd1/resourceGroups/rg-urbanos-spoke-dev-eus/providers/Microsoft.Compute/virtualMachines/vm-urbanos-spoke-dev-eus" --auth-type AAD