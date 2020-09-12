# List of ToDo

Postgres remote listening config - Fixed not tested
swappiness and huge transparant pages again - Fixed not tested
  - Maybe need to add the unlimited encryption for java - Fixed not tested

test the hostvars - kinda have it working in test


Finish CM Install:
    - CM Services
  - Cluster Config
    - Multiple Clusters
    - Before or After Kerb n TLS?


Add in the code to kerberise
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