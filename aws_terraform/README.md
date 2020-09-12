# Terraform AWS

Terraform Code to build an AWS Environment



# Commands to use:

```{bash}

# Start the Terraform script
terraform apply --var-file="../secrets/testing.tfvars"

# Kill the setup
terraform destroy --var-file="../secrets/testing.tfvars"


```