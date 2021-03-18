# Terraform a Secure Cluster

Some templates to build some quick test systems with Cloudera CDP Private Cloud Base (formerly CDP-DC)

# Notes

Update secrets with access keys etc
Update cm_config with whatever info needed
- note only testing with CDP 7.1.3 / 7.1.4 / 7.1.5
- Not from 7.1.5 CM version increments differently for 7.1.5 associate CM is 7.2.4

Use packer script in prepack_image to prepare a prewarmed image

Use terraform script to build the infra first
- wait to make sure that instances are in proper running state before starting ansible

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

ansible-playbooks/setup_ldap_demo.yml
- this:
  - configures the ldap settings back to FreeIPA (could still be some app coverage gaps)


ansible-playbooks/setup_autotls.yml
- this:
  - configures and sets up autotls

- warnings:
  - stop cluster services first to make sure it goes hitch free
  - install your cluster def first as autotls doesn't seem to pick up and configure tls settings for cluster defs after is has been enabled.


Hopefully Happy times after this!



## Testing Code

Setting up infra
Run from aws_terraform folder

```{bash}

terraform apply -var-file="../secrets/<yourfile>.tfvars"

```

NOTE: Wait for all the instances to have passed all status checks first.
Run from root folder

```{bash}

# Main function - to prepare the nodes

ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup.yml --private-key ../terraforming/secrets/brian_key_newse.pem --extra-vars "@secrets/secrets.yml"

# Setting up the cluster

ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup_cluster.yml --private-key ../terraforming/secrets/brian_key_newse.pem --extra-vars "@secrets/secrets.yml"

# Adding in new nodes
# Note that the new nodes should be added into inventory under extra_worker
# Copy them over to their standard group after so that we can reuse add_nodes
# in case we need more later
ansible-playbook -i aws_terraform/inventory ansible-playbooks/add_nodes.yml --private-key ../terraforming/secrets/brian_key_newse.pem --extra-vars "@secrets/secrets.yml"

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

-------------------
# Debug Cluster configs

```{bash}

# but we need to comment out the include bit to do this
ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup_cluster.yml --private-key ../terraforming/secrets/brian_terra_key.pem --extra-vars "@secrets/secrets.yml" --skip-tags apply_template --skip-tags management-service


```

--------------------------------
# IPA setup-dev

```{bash}

ansible-playbook -i aws_terraform/inventory ansible-playbooks/setup_ldap_demo.yml --private-key ../terraforming/secrets/brian_terra_key.pem --extra-vars "@secrets/secrets.yml" 


```

# Things that I have to keep redoing each time

Governance:
- Ranger Permissions can be incorrect
  - assign cm_admin user from ldap setup to be a HDFS superuser in ranger