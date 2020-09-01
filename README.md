# Terraform a Secure Cluster

Some templates to build some quick test systems with Cloudera CDP Private Cloud Base

## Testing Code

```{bash}

ansible-playbook -i aws_terraform/inventory ansible-playbooks/playbooks/test.yml --private-key ../terraforming/secrets/brian_terra_key.pem --extra-vars "@secrets/secrets.yml"


ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup.yml --private-key ../terraforming/secrets/brian_terra_key.pem -t run --extra-vars "@secrets/secrets.yml"


ansible -i aws_terraform/inventory ansible-playbooks/setup.yml --private-key ../terraforming/secrets/brian_terra_key.pem -m debug -a "var=hostvars[inventory_hostname]"

```