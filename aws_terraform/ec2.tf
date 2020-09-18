resource "aws_instance"  "security"  {
    ami = var.ami
    instance_type = "m5.4xlarge"
    key_name = var.ssh-key

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "security"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "master"  {
    ami = var.ami
    instance_type = "m5.2xlarge"
    key_name = var.ssh-key

    count = var.master_count

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "master"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "node"  {
    ami = var.ami
    instance_type = "m5.2xlarge"
    key_name = var.ssh-key

    count = var.new_node_count

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "worker"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}


resource "aws_instance"  "cdsw_master"  {
    ami = var.ami
    instance_type = "m5.2xlarge"
    key_name = var.ssh-key

    count = var.cdsw_master

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "master"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "cdsw_node"  {
    ami = var.ami
    instance_type = "m5.2xlarge"
    key_name = var.ssh-key

    count = var.cdsw_node

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "worker"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "cdf_master"  {
    ami = var.ami
    instance_type = "m5.2xlarge"
    key_name = var.ssh-key

    count = var.cdf_master

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "master"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "cdf_node"  {
    ami = var.ami
    instance_type = "m5.2xlarge"
    key_name = var.ssh-key

    count = var.cdf_node

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "worker"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}