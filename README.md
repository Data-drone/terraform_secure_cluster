# Terraform a Secure Cluster

Some templates to build some quick test systems with Cloudera CDP Private Cloud Base

## Testing Code

Run from root folder

```{bash}

# Main function
ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup.yml --private-key ../terraforming/secrets/brian_terra_key.pem --extra-vars "@secrets/secrets.yml"

# Debugging before
ansible-playbook -i aws_terraform/inventory ansible-playbooks/playbooks/test.yml --private-key ../terraforming/secrets/brian_terra_key.pem -t run --extra-vars "@secrets/secrets.yml"

# debugging vars
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m debug -a "var=hostvars[inventory_hostname]"

```