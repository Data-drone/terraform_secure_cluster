# Terraform AWS

Terraform Code to build an AWS Environment

How to Use:
adjust the example_tfvars.tfvars

Can set the master / new_node counts down to 0 too


# Commands to use:

```{bash}

# Start the Terraform script
terraform apply --var-file="../secrets/testing.tfvars"

# Kill the setup
terraform destroy --var-file="../secrets/testing.tfvars"


```

# TODOs

ensure that the logic for different types of nodes all work properly