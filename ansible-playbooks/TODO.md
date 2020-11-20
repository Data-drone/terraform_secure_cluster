# List of ToDo

# database
upgrade to new postgres needed for schema registry:
https://fojta.wordpress.com/2019/02/11/upgrade-postgresql-version-9-to-10/
https://github.com/geerlingguy/ansible-role-postgresql/issues/145

# More Flexible Installs?
Finish CM Install:
    - Multiple Clusters maybe? Stream plus normal
    - kinda sorted with tf configs

# Add nodes weirdness

Currently we need to manually run:
aws ec2 associate-iam-instance-profile --instance-id i-08fbf7a49f9adb41a --iam-instance-profile Name=sec_clus_profile

on AWS otherwise the instance profile role doesn't get attached
Also sec_clus_profile doesn't appear in list of profiles if we manually add in console vs cli

# using platform tools

Maybe we can update dfs_permissions_supergroup when we put in the ldap? 

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
  