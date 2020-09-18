# List of ToDo

need to add line to file /etc/krb5.conf
- renew_lifetime = 7d
This still seems to maybe be a little glitchy and duplicates shit

```{bash}

#testing - works
ansible -i aws_terraform/inventory ip-10-0-1-202.ap-southeast-2.compute.internal --private-key ../terraforming/secrets/brian_terra_key.pem -m lineinfile -a "path=/tmp/krb5.conf regexp='^  renew_lifetime*' insertbefore='^  forwardable' state=present line='  renew_lifetime = 7d'" --become


```

test the hostvars - kinda have it working in test

Finish CM Install:
    - Multiple Clusters

- Single Sign On
  - External Auth
    - see /etc/openldap/ldap.conf
    - need bind user
    - search paths
      - need to confirm on what is right setting
      - getting errors from pki on the ca settings?

- Planning for prewarm
  - parcel and unpack - how to?
  - we have followed all prewarming steps but it doesn't seem to be registering the repos.... there is something we are missing....

  - need to add the sha
    - sha for my parcel is: 51e05a25af52cd0efea2fc9e6811360f56cb12bb
      filename is: CDH-7.1.3-1.cdh7.1.3.p0.4992530-el7.parcel.sha

```{bash}

# forgot another fix
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m file -a "dest=/opt/cloudera/  content="51e05a25af52cd0efea2fc9e6811360f56cb12bb" owner=cloudera-scm group=cloudera-scm mode='0640'" --become

# temp fix

ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m copy -a "dest=/opt/cloudera/parcel-repo/CDH-7.1.3-1.cdh7.1.3.p0.4992530-el7.parcel.sha content="51e05a25af52cd0efea2fc9e6811360f56cb12bb" owner=cloudera-scm group=cloudera-scm mode='0640'" --become

# restart the agent
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-agent state=restarted" --become

# restart the server
ansible -i aws_terraform/inventory manager --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-server state=restarted" --become



```