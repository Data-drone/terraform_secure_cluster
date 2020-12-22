resource "aws_instance"  "security"  {
    ami = "ami-0b2045146eb00b617"
    instance_type = "m5a.2xlarge"
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

resource "aws_instance"  "manager"  {
    ami = var.ami
    instance_type = "m5a.2xlarge"
    # Putting this here as this is where Hue is 
    # this role is needed for hue to pick aws
    # all my templates put edge with manager for now
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "manager"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "master"  {
    ami = var.ami
    instance_type = var.master_instance
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    count = var.master_count

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "master", count.index])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "node"  {
    ami = var.ami
    instance_type = var.worker_instance
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    count = var.new_node_count

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "worker", count.index])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_volume_attachment" "ebs_docker_att" {
    device_name = "/dev/sdf"
    volume_id = aws_ebs_volume.cdsw_docker.id
    instance_id = aws_instance.cdsw_master.id
}


resource "aws_instance"  "cdsw_master"  {
    ami = var.ami
    instance_type = var.cdsw_master_instance
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "cdsw-master"])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_ebs_volume" "cdsw_docker" {
    availability_zone = aws_subnet.mainsubnet.availability_zone
    type              = "gp2"
    size              = 250
    
    tags = {
        owner = var.acc_owner
        enddate = var.enddate 
    }
}

resource "aws_instance"  "cdsw_node"  {
    ami = var.ami
    instance_type = var.cdsw_worker_instance
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    count = var.cdsw_node

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "cdsw-worker", count.index])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "cdf_master"  {
    ami = var.ami
    instance_type = var.cdf_master_instance
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    count = var.cdf_master

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "cdf-master", count.index])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}

resource "aws_instance"  "cdf_worker"  {
    ami = var.ami
    instance_type = var.cdf_worker_instance
    iam_instance_profile = aws_iam_instance_profile.sec_clus_profile.name
    key_name = var.ssh-key

    count = var.cdf_node

    root_block_device {
        volume_type           = var.volume_type
        volume_size           = var.volume_size
        delete_on_termination = true
    }

    tags = {
        Name = join("-", [var.owner, "cdf-worker", count.index])
        owner = var.acc_owner
        enddate = var.enddate
    }

    subnet_id = aws_subnet.mainsubnet.id

    security_groups = [aws_security_group.sec-clus-sg.id]

}