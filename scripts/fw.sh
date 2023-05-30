#!/bin/bash

SERVICE_IP="52.226.192.36"
FWPUBLICIP_NAME="pip-urbanos-hub-dev-eus"
RG="rg-urbanos-hub-dev-eus"
FWNAME="fw-urbanos-hub-dev-eus"


FWPUBLIC_IP=$(az network public-ip show -g $RG -n $FWPUBLICIP_NAME --query "ipAddress" -o tsv)

az network firewall nat-rule create --collection-name exampleset --destination-addresses $FWPUBLIC_IP --destination-ports 80 --firewall-name $FWNAME --name inboundrule --protocols Any --resource-group $RG --source-addresses '*' --translated-port 80 --action Dnat --priority 100 --translated-address $SERVICE_IP


nginxNamespace=nginx-ingress
nginxRepoName=ingress-nginx
nginxRepoUrl=https://kubernetes.github.io/ingress-nginx
nginxChartName=ingress-nginx
nginxReleaseName=nginx-ingress
nginxReplicaCount=3


helm list -n $nginxNamespace | grep $nginxReleaseName | awk '{print $1}'

                  helm install $nginxReleaseName $nginxRepoName/$nginxChartName \
                      --namespace $nginxNamespace \
                      --create-namespace \
                      --set controller.replicaCount=$nginxReplicaCount \
                      --set controller.nodeSelector."kubernetes\.io/os"=linux \
                      --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
                      --set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-internal"=true \
                      --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux

nginxServiceName=$(kubectl get svc -n $nginxNamespace)