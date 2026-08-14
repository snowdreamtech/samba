# Base Image (Debian Variant)
# Extends snowdreamtech/debian with Samba file sharing service.

FROM ghcr.io/snowdreamtech/debian:13.6.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root \
    SAMBA_VERSION=2:4.24.5+dfsg-1~bpo13+1

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Samba Image Based On Debian" \
    org.opencontainers.image.description="Docker Images for Samba on Debian. (amd64, arm32v7, arm64, ppc64le, riscv64, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/samba" \
    org.opencontainers.image.base.name="ghcr.io/snowdreamtech/debian:13.6.0" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/snowdreamtech/samba" \
    org.opencontainers.image.vendor="Snowdream Tech" \
    org.opencontainers.image.version="${VERSION}" \
    org.opencontainers.image.created="${BUILDTIME}" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.url="https://github.com/snowdreamtech/samba"

# Runtime Environment Configuration
ENV KEEPALIVE=${KEEPALIVE} \
    CAP_NET_BIND_SERVICE=${CAP_NET_BIND_SERVICE} \
    LANG=${LANG} \
    UMASK=${UMASK} \
    DEBUG=${DEBUG} \
    PASSWORDLESS_SUDO=${PASSWORDLESS_SUDO} \
    PGID=${PGID} \
    PUID=${PUID} \
    USER=${USER} \
    WORKDIR=${WORKDIR} \
    SAMBA_VERSION=${SAMBA_VERSION}

# Install Samba
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qqy update \
    && apt-get -qqy install --no-install-recommends \
    samba=${SAMBA_VERSION} \
    && apt-get -qqy clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/samba \
    && mkdir -p /var/lib/samba \
    && mkdir -p /var/log/samba \
    && mkdir -p /run/samba

# Copy Samba configuration
COPY smb.conf /etc/samba/smb.conf
COPY smb.full.conf /etc/samba/smb.full.conf

# Container Orchestration Files
COPY entrypoint.d /usr/local/bin/entrypoint.d

RUN chmod +x /usr/local/bin/entrypoint.d/*

# Expose Samba ports
EXPOSE 137/udp 138/udp 139 445

# Standard Healthcheck (Verification of core system responsiveness)
HEALTHCHECK NONE

# Process Execution
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/bin/bash"]
