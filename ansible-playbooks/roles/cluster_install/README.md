# Notes

Current Atlas has been baked in will need to make some of those dependencies optional to make the templates without atlas work properly again.

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