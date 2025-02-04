#!/bin/sh
set -e

# openssl rand -base64 33
if [ -z "${SAMBA_PASSWORD}" ]; then {
    SAMBA_PASSWORD=$(openssl rand -base64 33)
    echo "Generate random samba password: ${SAMBA_PASSWORD}"
}
fi

# change the samba password for user samba
echo -e "${SAMBA_PASSWORD}\n${SAMBA_PASSWORD}" | smbpasswd

# start samba
/usr/sbin/smbd -D -s /etc/samba/smb.conf
/usr/sbin/nmbd -D -s /etc/samba/smb.conf

# exec commands
if [ -n "$*" ]; then
    sh -c "$*"
fi

# keep the docker container running
# https://github.com/docker/compose/issues/1926#issuecomment-422351028
if [ "${KEEPALIVE}" -eq 1 ]; then
    trap : TERM INT
    tail -f /dev/null &
    wait
    # sleep infinity & wait
fi
