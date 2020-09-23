variable "access_key" {
    type = string
}

variable "secret_key" {
    type = string
}

variable "acc_owner" {
    type = string
}

variable "enddate" {
    type = string
    default = "permanent"
} 

variable "owner" {
    type = string
    default = "autosecure"
}

variable "ami" {
    type = string
    default = "ami-0b2045146eb00b617"
}

variable "AWS_REGION" {
    type = string
    default = "ap-southeast-2"
}

variable "ingress_cidr_blocks" {
    type = list(string)
    default = ["74.217.76.96/27"]
}

variable "ssh-key" {
    type = string
}

variable "new_node_count" {
    type = number
    default = 2
}

variable "master_count" {
    type = number
    default = 1
}

variable "cdsw_master" {
    type = number
    default = 0 # this should only ever be 1
}

variable "cdsw_node" {
    type = number
    default = 0
}

variable "cdf_master" {
    type = number
    default = 0
}

variable "cdf_node" {
    type = number
    default = 0
}

variable "volume_type" {
    type = string
    default = "gp2"
}

variable "volume_size" {
    type = number
    default = 600
}

variable "master_instance" {
    type = string
    default = "m5.2xlarge"
}

variable "worker_instance" {
    type = string
    default = "m5.2xlarge"
}

variable "cdsw_master_instance" {
    type = string
    default = "m5.2xlarge"
}

variable "cdsw_worker_instance" {
    type = string
    default = "m5.2xlarge"
}

variable "cdf_master_instance" {
    type = string
    default = "m5.2xlarge"
}

variable "cdf_worker_instance" {
    type = string
    default = "m5.2xlarge"
}
