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

variable "volume_type" {
    type = string
    default = "gp2"
}

variable "volume_size" {
    type = number
    default = 100
}
