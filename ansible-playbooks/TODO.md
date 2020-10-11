# List of ToDo

# IPA Config

need to add line to file /etc/krb5.conf
- renew_lifetime = 7d
This still seems to maybe be a little glitchy and duplicates shit

# Ansible glitches
test the hostvars - kinda have it working in test

# More Flexible Installs?
Finish CM Install:
    - Multiple Clusters maybe? Stream plus normal
    - kinda sorted with tf configs

# Prewarming Images
- Prewarm - test a cpl more times...
  - added torrents - see if that fixes the distribution problem

```{bash}

# restart the agent
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-agent state=restarted" --become

# restart the server
ansible -i aws_terraform/inventory manager --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-server state=restarted" --become

```


# using platform

```{bash}

# need kerberos for user
# kinit as user
spark-shell --principal <user> --keytab <user>.keytab

```

Try setting SSSD and NSCD first before looking at individual usersync
- sssd now mostly works...
- Hue LDAP? - nah lets flick it to Knox to solve
- Ranger LDAP? - still a gap with groups


Spark Jobs Issues:
- needed to pass keytab to spark
- user needed higher permissions to access hive tables
- needed user idbroker mapping

- stuck on kinit for spark it seems?
  - took out IDBroker and just used node IAM roles
  - maybe there is a way to get this to work but????

## Credentials Config