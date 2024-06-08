#!/bin/sh
set -e

# change the samba password for root
echo -e "$SAMBA_ROOT_PASSWORD\n$SAMBA_ROOT_PASSWORD" | smbpasswd -a -s root > /dev/null 2>&1

# start samba
/usr/sbin/smbd -D -F -s /etc/samba/smb.conf

# wait
wait