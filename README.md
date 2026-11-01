# Samba

[![CI Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/samba/ci.yml?branch=main&label=CI%20Pipeline)](https://github.com/snowdreamtech/samba/actions/workflows/ci.yml)
[![CD Pipeline](https://img.shields.io/github/actions/workflow/status/snowdreamtech/samba/cd.yml?branch=main&label=CD%20Pipeline)](https://github.com/snowdreamtech/samba/actions/workflows/cd.yml)
[![CodeQL](https://img.shields.io/github/actions/workflow/status/snowdreamtech/samba/codeql.yml?branch=main&label=CodeQL&logo=github)](https://github.com/snowdreamtech/samba/actions/workflows/codeql.yml)
[![Security Audit](https://img.shields.io/badge/Security-Zizmor%20%7C%20Trivy%20%7C%20Gitleaks-brightgreen)](https://github.com/snowdreamtech/samba/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/MIT)
![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/samba)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/samba/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/samba)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/samba)

[English](README.md) | [简体中文](README_zh-CN.md)

Docker image for Samba providing standardized container foundations with flexible entrypoint systems, multi-architecture support, and consistent configuration patterns across Alpine, Debian, and Rocky Linux distributions.

## Overview

The Samba container provides:

- **SMB/CIFS File Sharing**: High-performance network file sharing across heterogeneous platforms.
- **Standardized Dockerfiles** with OCI annotations and best practices.
- **Flexible entrypoint system** supporting custom initialization scripts.
- **Consistent environment variable configuration** across all variants.
- **Multi-architecture support** for diverse hardware platforms.
- **Three distribution variants**: Alpine (lightweight), Debian (default/widely-compatible), Rocky (enterprise).

## Version Information

| Distribution | Base Image | Samba Version | Architectures |
|--------------|------------|---------------|---------------|
| Alpine 3.24 | `snowdreamtech/alpine:3.24.1` | 4.23.10-r0 | i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x |
| Debian 13 (Default) | `snowdreamtech/debian:13.6.0` | 2:4.22.11+dfsg-0+deb13u1 | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| Rocky 10.2 | `snowdreamtech/rocky:10.2.0` | 4.23.5-111.el10_2 | amd64, arm64, ppc64le, s390x |

## Quick Start

### Docker CLI

#### Simple

```bash
docker run -d \
  --name=samba \
  -p 137:137/udp \
  -p 138:138/udp \
  -p 139:139 \
  -p 445:445 \
  -e TZ=Asia/Shanghai \
  -e SAMBA_PASSWORD=secret \
  --restart unless-stopped \
  snowdreamtech/samba:latest
```

#### Advanced (with Storage Volume)

```bash
docker run -d \
  --name=samba \
  -p 137:137/udp \
  -p 138:138/udp \
  -p 139:139 \
  -p 445:445 \
  -e TZ=Asia/Shanghai \
  -e SAMBA_PASSWORD=secret \
  -v /path/to/share:/share \
  --restart unless-stopped \
  snowdreamtech/samba:latest
```

### Docker Compose

```yaml
services:
  samba:
    image: snowdreamtech/samba:latest
    container_name: samba
    environment:
      - TZ=Asia/Shanghai
      - SAMBA_PASSWORD=secret
    ports:
      - "137:137/udp"
      - "138:138/udp"
      - "139:139"
      - "445:445"
    volumes:
      - /path/to/share:/share
    restart: unless-stopped
```

## Distribution Variants

### Debian (Default)

The recommended variant for most use cases, providing wide compatibility and extensive package availability.

```bash
docker run -d \
  --name=samba \
  -p 137:137/udp \
  -p 138:138/udp \
  -p 139:139 \
  -p 445:445 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:debian
```

**Supported Architectures**: amd64, arm32v7, arm64, ppc64le, riscv64, s390x

### Alpine

Lightweight image optimized for minimal footprint and resource efficiency.

```bash
docker run -d \
  --name=samba \
  -p 137:137/udp \
  -p 138:138/udp \
  -p 139:139 \
  -p 445:445 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:alpine
```

**Supported Architectures**: i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x

### Rocky

Enterprise-grade variant based on Rocky Linux, suitable for production environments requiring RHEL compatibility.

```bash
docker run -d \
  --name=samba \
  -p 139:139 \
  -p 445:445 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:rocky
```

**Supported Architectures**: amd64, arm64, ppc64le, s390x

## Configuration & Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `SAMBA_PASSWORD` | auto-generated | Password for default user `samba` |
| `TZ` | `UTC` | Container timezone |
| `DEBUG` | `false` | Enable verbose debugging logs |
| `PUID` | `0` | Process user ID |
| `PGID` | `0` | Process group ID |

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
