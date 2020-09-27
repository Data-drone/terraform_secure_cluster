# Packer Create Prewarmed Image

Create a prepack packer image in order to minimise the amount of time spent installing stuff

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
    