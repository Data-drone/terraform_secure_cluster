# List of ToDo

need to add line to file /etc/krb5.conf
- renew_lifetime = 7d
This still seems to maybe be a little glitchy and duplicates shit

test the hostvars - kinda have it working in test

Finish CM Install:
    - Multiple Clusters maybe? Stream plus normal

- Prewarm - test a cpl more times...
  - need to rebuild and see why it sometimes doesn't index properly

```{bash}

# debug prewarm a little
# parcel-repo checker
ansible -i aws_terraform/inventory all --private-key ../terraforming/secrets/brian_terra_key.pem -m find -a "paths=/opt/cloudera/parcel-repo patterns='*' use_regex=yes" --become


```


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