resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
    {
    security-id = aws_instance.security.id,
    security-ip = aws_instance.security.public_ip,
    security-dns = aws_instance.security.private_dns,
    manager-id = aws_instance.manager.id,
    manager-ip = aws_instance.manager.public_ip,
    manager-dns = aws_instance.manager.private_dns,
    master-id = aws_instance.master.*.id,
    master-ip = aws_instance.master.*.public_ip,
    master-dns = aws_instance.master.*.private_dns,
    node-id = aws_instance.node.*.id,
    node-ip = aws_instance.node.*.public_ip,
    node-dns = aws_instance.node.*.private_dns,
    cdsw_master-id = aws_instance.cdsw_master.id,
    cdsw_master-ip = aws_instance.cdsw_master.public_ip,
    cdsw_master-dns = aws_instance.cdsw_master.private_dns,
    cdsw_node-id = aws_instance.cdsw_node.*.id,
    cdsw_node-ip = aws_instance.cdsw_node.*.public_ip,
    cdsw_node-dns = aws_instance.cdsw_node.*.private_dns,
    cdf_master-id = aws_instance.cdf_master.*.id,
    cdf_master-ip = aws_instance.cdf_master.*.public_ip,
    cdf_master-dns = aws_instance.cdf_master.*.private_dns,
    cdf_worker-id = aws_instance.cdf_worker.*.id,
    cdf_worker-ip = aws_instance.cdf_worker.*.public_ip,
    cdf_worker-dns = aws_instance.cdf_worker.*.private_dns
    }
 )
 filename = "inventory"
}