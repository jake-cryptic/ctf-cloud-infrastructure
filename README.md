# ctf-cloud-infrastructure


### Command Index
```bash
# Login to Azure CLI
az login

# Set subscription
az account set --subscription "35akss-subscription-id"

# Create Service Principal
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```


```bash
# Initialise plugins etc
tf init

# Clean up terraform files
tf fmt

# Resources under management by TF
terraform state list

# Validate code
tf validate

# See what will change
tf plan

# Apply the changes
tf apply
```


### Explanations

main.tf
 - Cloud provider: Azure
 - Defines resource group

compute.tf
 - Define VMs

container-registry.tf
 - Define ACR instance
