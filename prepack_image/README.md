# Packer Create Prewarmed Image

NOTE: Setting prewarm to true is BETA

Create a prepack packer image in order to minimise the amount of time spent downloading and distributing parcels

## Tools

- Packer
- Ansible Playbooks from the playbooks folder

## Running the code

```bash

packer build --var-file="../secrets/packer_vars.json" create_prewarmed_image.json

```

This will build out an image for launching CDP Clusters off of.
CSDs for most of cloudera's suite of tools is automatically setup

## ToDos - Fix the Prewarming

Prewarming parcels will speed up the deployment of nodes / clusters as the download / distribute and activation of parcels is sped up

Currently with prewarmed parcels, cloudera-scm-manager needs to be restarted a few times so that it acknowledges that the parcels have been predownloaded. The only way way to see if this is done is to `grep` for `Discovered` INFO lines in the `cloudera-scm-server.log` file on the cloudera manager host

Currently with prepacked image impala doesn't start up correcting
  - Java path issue?
    - correct should the /usr/java/default/jre perhaps.
    - still blocked need to let CM deploy the parcel and compare results


### Things to try to fix prewarm

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