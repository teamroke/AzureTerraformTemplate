# AzureTerraformTemplate

This is a template with a sample deployment included.
Have an Azure account. 
Make sure you are logged in with Azure CLI.
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

To test the sample deployment cd to deployment.
This may cost money.
Run 
 - terraform init
 - terraform plan -out sample.plan
 - terraform apply sample.plan
 
To remove the sample deployment
Run
 - terraform plan -destroy -out destroy.plan
 - terraform apply destroy.plan
 
YMMV
