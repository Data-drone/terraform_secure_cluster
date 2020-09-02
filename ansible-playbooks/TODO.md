# List of ToDo

Postgres remote listening config - Fixed not tested
swappiness and huge transparant pages again - Fixed not tested
  - Maybe need to add the unlimited encryption for java - Fixed not tested

test the hostvars - kinda have it working in test


Finish CM Install:
  - need to see how we reshuffle the database config cause we need some structure to be able to get the users mapped properly
    - CM Services
  - Cluster Config
    - Multiple Clusters
    - Before or After Kerb n TLS?


Add in the code to kerberise
- Should be able to just submit the details to the cluster as the krb5 and everything was done by free ipa
  - set the admin server / admin account / domain setting and encryption
  - Need to investigate Kerberos Ticket Renewer for Hue

- Maybe can just set the tls easily as well?
  - Just point to cert bundle
  - provide the private key to get into the hosts
  - restart


- Single Sign On
  - External Auth
    - see /etc/openldap/ldap.conf
    - need bind user
    - search paths
      - need to confirm on what is right setting
      - getting errors from pki on the ca settings?