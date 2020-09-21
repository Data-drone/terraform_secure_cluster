# Terraform a Secure Cluster

Some templates to build some quick test systems with Cloudera CDP Private Cloud Base (formerly CDP-DC)

# Notes

Update secrets with access keys etc
Update cm_config with whatever info needed
- note only testing with CDP 7.1.3

Use packer script in prepack_image to prepare a prewarmed image
- note sometimes that parcel still doesn't get picked up properly
- this can still be BUGGY in terms of the preloaded parcels being detected.
  - it seems to be a permission problem perhaps.
  - sometimes restarting manager and agent a few times fixes.
  - run tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log
    to follow the cluster deployment in terminal and see if parcel deploy is causing issues

Use terraform script to build the infra first

Cluster templates are in:
ansible-playbooks/roles/cluster_install/clusters

Use setup script:
ansible-playbooks/setup.yml
- this installs
  - freeipa on security node
  - setup external postgresdb
  - adds java and deploys postgres driver
  - installs cm-manager and agents
  - installs license

ansible-playbooks/setup_cluster.yml
- this:
  - deploys the cluster_def in your cm_config

ansible-playbooks/setup_autotls.yml
- this:
  - configures and sets up autotls

- warnings:
  - stop cluster services first to make sure it goes hitch free
  - install your cluster def first as autotls doesn't seem to pick up and configure tls settings for cluster defs after is has been enabled.


Hopefully Happy times after this!



## Testing Code

Run from root folder

```{bash}

# Main function
ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup.yml --private-key ../terraforming/secrets/brian_terra_key.pem --extra-vars "@secrets/secrets.yml"

# run single role


# Debugging before
ansible-playbook -i aws_terraform/inventory ansible-playbooks/playbooks/test.yml --private-key ../terraforming/secrets/brian_terra_key.pem -t run --extra-vars "@secrets/secrets.yml"

# debugging vars
ansible -i aws_terraform/inventory cdp_servers --private-key ../terraforming/secrets/brian_terra_key.pem -m debug -a "var=inventory_hostname"

```

# Quick Debug

ipa server crashes with prewarmed image due to:

"msg": "httpd is already configured to listen on 443."

fix option remove: mod_ssl

```{bash}

ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m yum -a "name=mod_ssl state=absent" --become

```

cloudera manager agent is adding this....

---------------------------------

Issue with prewarming...
Testing permissions?

```{bash}

ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m file -a "path=/opt/cloudera/parcel-repo recurse=true owner=cloudera-scm group=cloudera-scm mode='0740'" --become

# restart the agent
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-agent state=restarted" --become

# restart the server
ansible -i aws_terraform/inventory manager --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-server state=restarted" --become



```
