resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tmpl",
    {
    security-id = aws_instance.security.id,
    security-ip = aws_instance.security.public_ip,
    security-dns = aws_instance.security.private_dns,
    master-id = aws_instance.master.*.id,
    master-ip = aws_instance.master.*.public_ip,
    master-dns = aws_instance.master.*.private_dns,
    node-id = aws_instance.node.*.id,
    node-ip = aws_instance.node.*.public_ip,
    node-dns = aws_instance.node.*.private_dns,
    }
 )
 filename = "inventory"
}