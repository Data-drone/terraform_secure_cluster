access_key = "blah"
secret_key = "blah"
ami = "ami-0301131979a536fe3" # optional if you use the prepack too
region = "us-west-2"
acc_owner = "specialops"
enddate = "forever"

# nodes
master_count = 3
master_instance = "m5.2xlarge"
new_node_count = 3
worker_instance = "m5.2xlarge"
cdsw_master = 0 # either 0 or 1
cdsw_master_instance = "m5.2xlarge"
cdsw_node = 0
cdsw_worker_instance = "m5.2xlarge"
cdf_master = 0
cdf_master_instance = "m5.2xlarge"
cdf_node = 0
cdf_worker_instance = "m5.2xlarge"

ssh-key = "my_key"
ingress_cidr_blocks = ["100.100.100.100/27", 
                        "200.200.200.200/29"]