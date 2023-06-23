#!/bin/bash

#az login --use-device-code
#az login --scope https://management.core.windows.net//.default
#az login --tenant bea34d45-5ce0-4677-98b9-1b872aa89a37
az account set --subscription "c26f81cf-321b-4132-8526-3f97a01e19d2"
az login --service-principal -u -p  --tenant bea34d45-5ce0-4677-98b9-1b872aa89a37
#az extension add --upgrade -n bastion
#az extension add --upgrade -n ssh

az network bastion ssh --name "snap-urbanos-spk-dev-eus" --resource-group "rg-urbanos-spk-dev-eus" --target-resource-id "/subscriptions/c26f81cf-321b-4132-8526-3f97a01e19d2/resourceGroups/rg-urbanos-spk-dev-eus/providers/Microsoft.Compute/virtualMachines/vm-urbanos-spk-dev-eus" --auth-type AAD
az network bastion ssh --name "snap-urbanos-spk-dev-eus" --resource-group "rg-urbanos-spk-dev-eus" --target-resource-id "/subscriptions/c26f81cf-321b-4132-8526-3f97a01e19d2/resourceGroups/rg-urbanos-spk-dev-eus/providers/Microsoft.Compute/virtualMachines/vm-urbanos-runner-dev-eus"  --auth-type AAD
#nslookup aks-urbanos-spoke-dev-eus-p3gk6n5u.2c9d0e8f-a186-4266-9fa3-5715666dd8ca.privatelink.eastus.azmk8s.io
az aks get-credentials --resource-group "rg-urbanos-spk-dev-eus"  --name "aks-urbanos-spk-dev-eus"

sudo az aks install-cli

kubectl get nodes -o wide
kubectl get services

az aks stop --name juno-dev1-0531-cluster --resource-group urbanos-team
az aks show --name juno-dev1-0531-cluster --resource-group urbanos-team
az aks start --name juno-dev1-0531-cluster --resource-group urbanos-team


az purview account add-root-collection-admin --name "pbi-aim-purview-dev-eus" --object-id "1f2daa50-0dfc-44fd-82fe-978ecef07d6e" --resource-group "rg-aim-lake-dev-eus"
az purview account add-root-collection-admin --name "pbi-aim-purview-dev-eus" --object-id "592308cb-ed13-4076-b3f5-d420a56748ad" --resource-group "rg-aim-lake-dev-eus"