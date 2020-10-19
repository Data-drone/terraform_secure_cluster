# List of ToDo

# More Flexible Installs?
Finish CM Install:
    - Multiple Clusters maybe? Stream plus normal
    - kinda sorted with tf configs

# Prewarming Images
- Prewarm - test a cpl more times...
  - still issues with prewarming need to find the secret sauce

  - theories in test
    - something to do with `tar zxf` vs `unarchive` in ansible
      - testing redistributed and activating on prewarmed image by deleting predistributed version
        - letting CM `tar zxf` and link seems to work....
    - java differences
    - env flags 

  - need clean up cloudera-scm-agent and uuid especially if we are building on the base like with the GPU images - added v1

```{bash}

# restart the agent
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-agent state=restarted" --become

# restart the server
ansible -i aws_terraform/inventory manager --private-key ../terraforming/secrets/brian_terra_key.pem -m systemd -a "name=cloudera-scm-server state=restarted" --become

```


# using platform tools

```{bash}

# need kerberos for user
# kinit as user
spark-shell --principal <user> --keytab <user>.keytab

```

Try setting SSSD and NSCD first before looking at individual usersync
- sssd now mostly works...
- Ranger LDAP? - still a gap with groups


Spark Jobs Issues:
- needed to pass keytab to spark
- user needed higher permissions to access hive tables
- needed user idbroker mapping - dropped IDBroker for now since it isn't supported anyway
  - technical issue is that Spark was delegating down the token properly so idbroker didn't see a valid kerberos token to map to a valid role


## Add a jump box

- Create a terraform / ansible / packer box?

## Credentials Config
  