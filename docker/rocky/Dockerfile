# Samba Image (Rocky Variant)
# Provides Samba file sharing service on Rocky Linux 10.2.

FROM ghcr.io/snowdreamtech/rocky:10.2.0

# Build-time Configuration
ARG BUILDTIME \
    VERSION \
    REVISION \
    SAMBA_VERSION=4.23.5-109.el10_2 \
    KEEPALIVE=0 \
    CAP_NET_BIND_SERVICE=0 \
    LANG=C.UTF-8 \
    UMASK=022 \
    DEBUG=false \
    PASSWORDLESS_SUDO=false \
    PGID=0 \
    PUID=0 \
    USER=root \
    WORKDIR=/root

# Standard OCI Metadata (https://github.com/opencontainers/image-spec)
LABEL org.opencontainers.image.authors="Snowdream Tech" \
    org.opencontainers.image.title="Samba Image Based On Rocky" \
    org.opencontainers.image.description="Docker Images for Samba on Rocky. (amd64, arm64, ppc64le, s390x)" \
    org.opencontainers.image.documentation="https://hub.docker.com/r/snowdreamtech/samba" \
    org.opencontainers.image.base.name="ghcr.io/snowdreamtech/rocky:10.2.0" \
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
    WORKDIR=${WORKDIR}

# Install Samba
RUN set -eux \
    && dnf -y --allowerasing --setopt=*.skip_if_unavailable=true update \
    && dnf -y --allowerasing --setopt=*.skip_if_unavailable=true install \
    samba-${SAMBA_VERSION}* \
    samba-common-${SAMBA_VERSION}* \
    && dnf -y --allowerasing autoremove \
    && dnf -y --allowerasing clean all \
    && rm -rf /var/cache/dnf \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Container Orchestration Files
COPY docker-entrypoint.sh /usr/local/bin/
COPY entrypoint.d /usr/local/bin/entrypoint.d
COPY smb.conf /etc/samba/smb.conf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.d/*

# Standard Healthcheck (Verification of Samba service)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD smbstatus --brief || exit 1

# Expose Samba ports
EXPOSE 139 445

# Process Execution
USER root
WORKDIR /root
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["smbd", "--foreground", "--no-process-group"]
