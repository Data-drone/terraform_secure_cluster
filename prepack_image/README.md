# Packer Create Prewarmed Image

Create a prepack packer image in order to minimise the amount of time spent downloading and distributing parcels

## Tools

Packer
Ansible Playbooks from the playbooks folder

## Testing

```bash

packer build --var-file="../secrets/packer_vars.json" create_prewarmed_image.json

```

## ToDos

Currently with prepacked image impala doesn't start up correcting
- theories
  - Java path issue?
    - correct should the /usr/java/default/jre perhaps.
    - still blocked need to let CM deploy the parcel and compare results

## test stopping the parcel management in CM

when prewarming images, it still seems to require waiting on CM to validate and accept a package before it will be detected.

To speed this up, we can set this flag I think

cloudera_manager_set_parcel_validation:
  file.replace:
    - name: /opt/cloudera/cm/bin/cm-server
    - pattern: "CMF_OPTS -server"
    - repl: "CMF_OPTS -server\"\nCMF_OPTS=\"$CMF_OPTS -Dcom.cloudera.parcel.VALIDATE_PARCELS_HASH=false"
    - unless: grep "VALIDATE_PARCELS_HASH=false" /opt/cloudera/cm/bin/cm-server

######### DIDN'T WORK but maybe part of what we need do
----- recheck OPSAPS-50660
Add in 

CMF_OPTS="$CMF_OPTS -Dcom.cloudera.parcel.VALIDATE_PARCELS_HASH=false"

after

CMF_OPTS="$CMF_OPTS -server"

```{bash}
# need to revise
ansible -i aws_terraform/inventory all --private-key secrets/brian_terra_key.pem -m lineinfile -a "path=/opt/cloudera/cm/bin/cm-server regexp='CMF_OPTS="\$CMF_OPTS -server"' line='CMF_OPTS -server\"\nCMF_OPTS=\"\$CMF_OPTS -Dcom.cloudera.parcel.VALIDATE_PARCELS_HASH=false'"

ansible -i aws_terraform/inventory manager --private-key secrets/brian_terra_key.pem -m lineinfile -a "path=/tmp/cm-server-test regexp='CMF_OPTS="\$CMF_OPTS -server"' line='{% raw %}CMF_OPTS -server\"\nCMF_OPTS=\"$CMF_OPTS -Dcom.cloudera.parcel.VALIDATE_PARCELS_HASH=false{% endraw %}'"

```