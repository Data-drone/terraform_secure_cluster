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

# LDAP Dev

```{bash}

# run on security node with freeipa?
# don't need h and b and stuff on the admin node
# coded by freeipa into /etc/openldap/ldap.conf
ldapsearch -h ldaps://ip-10-0-1-118.ap-southeast-2.compute.internal -b "dc=seccluster,dc=local" -D admin -W ADMPassword1

ldapsearch -x uid=admin

```

configs

add a ldap user that has `User Administrator Role`

```{bash}

# 

# users
cn=users,cn=accounts,dc=seccluster,dc=local

# groups
cn=groups,cn=accounts,dc=seccluster,dc=local



```

-- debug

```{bash}

# add the ipa cert into the java keystore
cp /usr/java/jdk1.8.0_232-cloudera/jre/lib/security/cacerts /usr/java/jdk1.8.0_232-cloudera/jre/lib/security/jssecacerts

sudo /usr/java/jdk1.8.0_232-cloudera/jre/bin/keytool -import -alias seccluster.local -keystore /usr/java/jdk1.8.0_232-cloudera/jre/lib/security/jssecacerts -file /etc/ipa/ca.crt

# default password is changeit
# we would need pxpect or a role to do this.... 

# prompts for a pexpect
# Enter keystore password:
# Trust this certificate? [no]:

```

# using platform

```{bash}

# need kerberos for user
# kinit as user
spark-shell --principal <user> --keytab <user>.keytab

```