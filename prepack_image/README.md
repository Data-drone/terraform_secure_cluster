# TODO

Create a prepack packer image in order to minimise the amount of time spent installing stuff

## Tools

Packer
Ansible Playbooks from the playbooks folder

## Testing

```bash

packer build --var-file="../secrets/packer_vars.json" create_prewarmed_image.json

```

## Temp Ansible Fix

Temp fix for the symlink and the dont_delete and chowning

```{bash}

ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m file -a "src=/opt/cloudera/parcels/CDH-7.1.3-1.cdh7.1.3.p0.4992530 dest=/opt/cloudera/parcels/CDH state=link" --become

ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m file -a "path=/opt/cloudera/parcels/CDH/.dont_delete state=touch owner=cloudera-scm group=cloudera-scm" --become


# bulk chown
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m file -a "path=/opt/cloudera/ state=directory recurse=yes owner=cloudera-scm group=cloudera-scm mode='0755'" --become


```

need a sha and torrent?
That is what is produced by a normal dload and distribute