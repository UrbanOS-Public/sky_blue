#!/bin/bash

#az login --use-device-code
#az login --scope https://management.core.windows.net//.default
#az login --tenant 2d37ebc6-ffa6-4903-b10e-f97062540597
az account set --subscription "962dc63d-463c-48c1-a588-20b22134bbd1"

#az extension add --upgrade -n bastion
#az extension add --upgrade -n ssh

az network bastion ssh --name "snap-urbanos-spoke-dev-eus" --resource-group "rg-urbanos-spoke-dev-eus" --target-resource-id "/subscriptions/962dc63d-463c-48c1-a588-20b22134bbd1/resourceGroups/rg-urbanos-spoke-dev-eus/providers/Microsoft.Compute/virtualMachines/vm-urbanos-jumpbox-dev-eus" --auth-type AAD
az network bastion ssh --name "snap-urbanos-spoke-dev-eus" --resource-group "rg-urbanos-spoke-dev-eus" --target-resource-id "/subscriptions/962dc63d-463c-48c1-a588-20b22134bbd1/resourceGroups/rg-urbanos-spoke-dev-eus/providers/Microsoft.Compute/virtualMachines/vm-urbanos-runner-dev-eus"  --auth-type AAD
#nslookup aks-urbanos-spoke-dev-eus-p3gk6n5u.2c9d0e8f-a186-4266-9fa3-5715666dd8ca.privatelink.eastus.azmk8s.io
az aks get-credentials --resource-group "rg-urbanos-spoke-dev-eus"  --name "aks-urbanos-spoke-dev-eus"

sudo az aks install-cli

kubectl get nodes -o wide
kbectl get services

az aks stop --name juno-dev1-0531-cluster --resource-group urbanos-team
az aks show --name juno-dev1-0531-cluster --resource-group urbanos-team
az aks start --name juno-dev1-0531-cluster --resource-group urbanos-team
