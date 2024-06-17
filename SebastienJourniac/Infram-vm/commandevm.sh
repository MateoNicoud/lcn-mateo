#!/usr/bin/env bash
mkdir -p /home/grough/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7gBP07fjsIF+r9/R++RvTOJHxVBEqr/B+sZGED/u0R journiac@pc-de-sebastien" > /home/grough/.ssh/authorized_keys
chmod 600 /home/grough/.ssh/authorized_keys
chmod 700 /home/grough/.ssh
chown -R grough:grough /home/grough/.ssh
echo 'grough ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/grough
chmod 440 /etc/sudoers.d/grough
