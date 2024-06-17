#!/usr/bin/env bash

mkdir -p /home/andrea/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2nNlUiutuaTMmRxKb93IOLmA12cCXXTx+5Kho52I68 andrea.thouvenot@le-campus-numerique.fr" > /home/andrea/.ssh/authorized_keys
chmod 600 /home/andrea/.ssh/authorized_keys
chown -R andrea:andrea /home/andrea/.ssh

echo 'andrea ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/andrea
chmod 440 /etc/sudoers.d/andrea