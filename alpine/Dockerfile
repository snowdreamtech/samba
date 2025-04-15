FROM snowdreamtech/alpine:3.21.3

# OCI annotations to image
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Samba Image Based On Alpine" \
    org.opencontainers.image.description="Docker Images for Samba on Alpine. (i386, amd64, arm32v6, arm32v7, arm64, ppc64le,riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/samba" \
    org.opencontainers.image.base.name="snowdreamtech/samba:alpine" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/samba" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="4.20.6" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/samba"

# keep the docker container running
ENV KEEPALIVE=1 \
    # The cap_net_bind_service capability in Linux allows a process to bind a socket to Internet domain privileged ports, 
    # which are port numbers less than 1024. 
    CAP_NET_BIND_SERVICE=1 \
    SAMBA_VERSION=4.20.6-r1 \
    SAMBA_PASSWORD=

ARG GID=1000 \
    UID=1000  \
    USER=samba \
    WORKDIR=/home/samba

# Create a user with UID and GID
RUN if [ "${USER}" != "root" ]; then \
    addgroup -g ${GID} ${USER}; \
    adduser -h /home/${USER} -u ${UID} -g ${USER} -G ${USER} -s /bin/sh -D ${USER}; \
    # sed -i "/%sudo/c ${USER} ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers; \
    fi

RUN apk add --no-cache \
    samba=${SAMBA_VERSION} \
    && find /  -name "samba" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /usr/sbin  -name "samba*" -exec chown -Rv ${USER}:${USER} {} \; \
    && find /  -name "smbd" -exec chown -Rv ${USER}:${USER} {} \; 

# Enable CAP_NET_BIND_SERVICE
RUN if [ "${USER}" != "root" ] && [ "${CAP_NET_BIND_SERVICE}" -eq 1 ]; then \
    apk add --no-cache libcap; \
    setcap 'cap_net_bind_service=+ep' `which smbd`; \
    fi

# Switch to the user
USER ${USER}

# Set the workdir
WORKDIR ${WORKDIR}

# exposes samba's default ports 
# 
# https://wiki.samba.org/index.php/Samba_AD_DC_Port_Usage
# 
# Service	Port	Protocol
# DNS *	53	tcp/udp
# Kerberos	88	tcp/udp
# ntp **	123	udp
# End Point Mapper (DCE/RPC Locator Service)	135	tcp
# NetBIOS Name Service	137	udp
# NetBIOS Datagram	138	udp
# NetBIOS Session	139	tcp
# LDAP	389	tcp/udp
# SMB over TCP	445	tcp
# Kerberos kpasswd	464	tcp/udp
# LDAPS ***	636	tcp
# Global Catalog	3268	tcp
# Global Catalog SSL ***	3269	tcp
# Dynamic RPC Ports ****	49152-65535	tcp
EXPOSE 135/tcp 137/udp 138/udp 139/tcp 389/udp 389/tcp 445/TCP

COPY smb.conf /etc/samba/

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]