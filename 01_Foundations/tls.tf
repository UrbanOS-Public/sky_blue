# The private key generated by this resource will be stored unencrypted in your Terraform state file. 
# Use of this resource for production deployments is not recommended. 
# Instead, generate a private key file outside of Terraform and distribute it securely to the system where Terraform will be run.
# Use the following script to generate an SSH key pair and push resulting file as secrets in the Key Vault:
# $ cd scripts
# $ ./aks_key_pair.sh [dev|uat|prd]
# This resource is primarily intended for easily bootstrapping throwaway development environments.

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "privatekey" {
  name         = "aks-private-sshkey"
  value        = tls_private_key.this.private_key_openssh
  key_vault_id = module.key_vault.id
  
  depends_on = [ 
    module.key_vault,
    azurerm_key_vault_access_policy.agent,
    azurerm_key_vault_access_policy.admin
  ]
}

resource "azurerm_key_vault_secret" "publickey" {
  name         = "aks-public-sshkey"
  value        = tls_private_key.this.public_key_openssh
  key_vault_id = module.key_vault.id
  depends_on = [ 
    module.key_vault,
    azurerm_key_vault_access_policy.agent,
    azurerm_key_vault_access_policy.admin
  ]
}