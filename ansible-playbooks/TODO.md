# List of ToDo

need to add line to file /etc/krb5.conf
- renew_lifetime = 7d

```{bash}

#testing - works
ansible -i aws_terraform/inventory ip-10-0-1-202.ap-southeast-2.compute.internal --private-key ../terraforming/secrets/brian_terra_key.pem -m lineinfile -a "path=/tmp/krb5.conf regexp='^  renew_lifetime*' insertbefore='^  forwardable' state=present line='  renew_lifetime = 7d'" --become


```

Postgres remote listening config - Fixed not tested
swappiness and huge transparant pages again - Fixed not tested
  - Maybe need to add the unlimited encryption for java - Fixed not tested

test the hostvars - kinda have it working in test

Finish CM Install:
    - Multiple Clusters

Add in the code to kerberise
  - Need to investigate Kerberos Ticket Renewer for Hue

- Maybe can just set the tls easily as well?
  - restart

- Single Sign On
  - External Auth
    - see /etc/openldap/ldap.conf
    - need bind user
    - search paths
      - need to confirm on what is right setting
      - getting errors from pki on the ca settings?

- Planning for prewarm
  - parcel and unpack - how to?