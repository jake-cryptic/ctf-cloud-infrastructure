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
tf format

# Validate code
tf validate

# See what will change
tf plan

# Apply the changes
tf apply
```
