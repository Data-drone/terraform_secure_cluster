# Adding Nodes

1. add the nodes into the security group / vpc with the same pem key to access
2. Add the node to your ansible inventory under extra_worker group
3. Run the  `add_nodes.yml` workbook on it
4. manually move the now configured node in your inventory back to one of the main groups like workers so that you can reuse this process as needed

