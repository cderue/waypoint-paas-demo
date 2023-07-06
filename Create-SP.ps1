# Log into Azure
Az login

# Show current subscription (use 'Az account set' to change subscription)
Az account show

# variables
$subscriptionId=$(az account show --query id -o tsv)
$appName="Waypoint-PaaS-Demo"
$RBACRole="Contributor"

# Create AAD App and Service Principal and assign RBAC Role
az ad sp create-for-rbac --name $appName `
    --role $RBACRole `
    --scopes /subscriptions/$subscriptionId `
    --sdk-auth