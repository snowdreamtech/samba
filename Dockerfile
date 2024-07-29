FROM snowdreamtech/alpine:3.20.2

LABEL maintainer="snowdream <sn0wdr1am@qq.com>"

ENV SAMBA_ROOT_PASSWORD=

RUN apk add --no-cache samba=4.19.6-r0

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
EXPOSE 135/tcp 137/udp 138/udp 139/tcp 389/tcp 445/TCP

COPY smb.conf /etc/samba/

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]