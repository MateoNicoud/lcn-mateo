#!/usr/bin/env bash

uservm=grough
IPvm=192.168.122.52

ssh-keygen -f "/home/journiac/.ssh/known_hosts" -R $IPvm

virt-install --connect=qemu:///system \
 --name="vmtest2" \
 --ram=2048 \
 --vcpus=2 \
 --disk size=20,path="/var/lib/libvirt/images/vmtest2.qcow2,bus=virtio,cache=none" \
 --initrd-inject=preseed.cfg \
 --initrd-inject=commandevm.sh \
 --noautoconsole \
 --location http://ftp.debian.org/debian/dists/bookworm/main/installer-amd64/ \
 --graphics spice \
 --noautoconsole \
 --autostart \
 --wait

while ! nc -nz $IPvm 22; do
    sleep 1
    echo "On attend"
done
echo "VM is up"

scp -o "StrictHostKeyChecking no" installmariadb.sh $uservm@$IPvm:
ssh -o "StrictHostKeyChecking no" $uservm@$IPvm "sudo bash ./installmariadb.sh"
echo "MariaDB is installed"
scp -o "StrictHostKeyChecking no" installphp.sh $uservm@$IPvm:
ssh -o "StrictHostKeyChecking no" $uservm@$IPvm "sudo bash ./installphp.sh"
echo "PHP is installed"
scp -o "StrictHostKeyChecking no" installapache.sh $uservm@$IPvm:
ssh -o "StrictHostKeyChecking no" $uservm@$IPvm "sudo bash ./installapache.sh"
echo "Apache is installed"
scp -o "StrictHostKeyChecking no" install_laravel.sh $uservm@$IPvm:
ssh -o "StrictHostKeyChecking no" $uservm@$IPvm "sudo bash ./install_laravel.sh"
echo "Laravel is installed"
scp -o "StrictHostKeyChecking no" config_laravel.sh $uservm@$IPvm:
ssh -o "StrictHostKeyChecking no" $uservm@$IPvm "bash ./config_laravel.sh"
