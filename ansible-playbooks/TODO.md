# List of ToDo

# More Flexible Installs?
Finish CM Install:
    - Multiple Clusters maybe? Stream plus normal
    - kinda sorted with tf configs

# Prewarming Images

  - need clean up cloudera-scm-agent and uuid especially if we are building on the base like with the GPU images - added v1


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

##
- check about moving some of the cluster setup vars in cm_config of having to have them in every single cluster template

## Add a jump box

- Create a terraform / ansible / packer box?

## Credentials Config
  