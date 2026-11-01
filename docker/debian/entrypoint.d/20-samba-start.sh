#!/bin/sh
set -e

if [ "$DEBUG" = "true" ]; then echo "→ [samba] Starting samba..."; fi

# openssl rand -base64 33
if [ -z "${SAMBA_PASSWORD}" ]; then
  {
    SAMBA_PASSWORD=$(openssl rand -base64 33)
    echo "Generate random samba password: ${SAMBA_PASSWORD}"
  }
fi

# change the samba password for user samba
printf '%s\n%s\n' "${SAMBA_PASSWORD}" "${SAMBA_PASSWORD}" | smbpasswd >/dev/null 2>&1

# start samba
/usr/sbin/smbd -D -s /etc/samba/smb.conf
/usr/sbin/nmbd -D -s /etc/samba/smb.conf

if [ "$DEBUG" = "true" ]; then echo "→ [samba] Samba started."; fi
