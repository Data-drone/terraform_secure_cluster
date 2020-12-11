# Notes

Current Atlas has been baked in will need to make some of those dependencies optional to make the templates without atlas work properly again.

Schema Registry requires Postgres 10+

## Logic Flow for cluster builds

The cluster install role does everything to setup a cluster.

It uses: 
- cm_config to get the csds / parcel_repositories needed
- it gets hosts from cloudera manager
  - this is currently just for debug
- `host.j2` and `instantiator.j2` build the system
- host_templates are defined in the cluster yaml under `clusters` and are retrieved by `host.j2`
- adding in the hosts that we are applying the template to is done by `instantiator.j2`
  - instantiator is getting the cluster hosts from `groups['cdp_servers']` which comes from the ansible inventory

#### TODO - HDFS

set supergroup to the ldap group cdp_admins


#### TODO CDSW

- fix the addresses - putting in the right internal aws ip for cdsw config flag
- maybe someway to detect when CDSW is actually ready?

- script to create first user and possible switch to LDAP integration properly
- preload CML Viz Apps image
- preload a R-Studio Image

- GPU Setup
  - preload a cuda image?
  - rapids image?

#### TODO Multiclusters

If we want to deploy multiple cluster defs for smaller clusters we can look at: 

JMESPath tests:
From Hostvars

`hostvars.*.{inventory_hostname: inventory_hostname, host_template: host_template} | [?host_template=='HostTemplate-Edge']`

we could add a cluster name then trigger the cluster_install script onto a subset of the hostvars based on cluster def rather than using the `groups['cdp_servers']`

Options:
- If we want to redefine this, we would need to get instantiator to get the cluster details from somewhere else.
- Also need to consider that cardinality is being calculated via the inventory too.

## Atlas configs

- capture whitelist setting


## Ranger Configs

- Need to Amend HDFS configs to enable ranger - done

- Need to Amend Ranger? Config so that Ranger can work with and override hadoop-acls


Configs that need to be set in ranger so that basic setups work?

-- write access for knox to ranger audit for failed logins
[
    {
        "isEnabled": true,
        "service": "cm_hdfs",
        "name": "ranger_audits",
        "description": "Access to Audit Folder",
        "isAuditEnabled": true,
        "resources": {
            "path": {
                "values": [
                    "/ranger/audits"
                ],
                "isExcludes": false,
                "isRecursive": true
            }
        },
        "policyItems": [
            {
                "accesses": [
                    {
                        "type": "read",
                        "isAllowed": true
                    },
                    {
                        "type": "write",
                        "isAllowed": true
                    }
                ],
                "users": [
                    "knox"
                ],
                "groups": [],
                "roles": [],
                "conditions": [],
                "delegateAdmin": false
            }
        ],
        "denyPolicyItems": [],
        "allowExceptions": [],
        "denyExceptions": [],
        "dataMaskPolicyItems": [],
        "rowFilterPolicyItems": [],
        "serviceType": "hdfs",
        "options": {},
        "validitySchedules": [],
        "policyLabels": [],
        "zoneName": "",
        "isDenyAllElse": false
    }
]

-- update ATLAS_ENTITIES so that ranger tag sync can create
-- (not done yet but we need find this by name (will be autocreated and update))

[{"id":28,"guid":"007ecb35-1b45-4c8d-9b54-5897813fe41f","isEnabled":true,"version":1,"service":"cm_kafka","name":"ATLAS_ENTITIES","policyType":0,"policyPriority":0,"description":"Policy for ATLAS_ENTITIES","isAuditEnabled":true,"resources":{"topic":{"values":["ATLAS_ENTITIES"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"create","isAllowed":true},{"type":"configure","isAllowed":true},{"type":"publish","isAllowed":true}],"users":["atlas"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":false},{"accesses":[{"type":"consume","isAllowed":true}],"users":["rangertagsync"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kafka","options":{},"validitySchedules":[],"policyLabels":[],"zoneName":"","isDenyAllElse":false}]