#!/bin/sh

touch /etc/sysctl.d/99-sysctl.conf
echo "vm.swappiness = 10"         >> /etc/sysctl.d/99-sysctl.conf
echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.d/99-sysctl.conf
