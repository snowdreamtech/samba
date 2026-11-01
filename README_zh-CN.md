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

Samba 的 Docker 镜像，基于 Alpine、Debian 和 Rocky Linux 提供标准化容器基础、灵活的 entrypoint 系统、多架构支持和统一的配置体系。

## 概述

Samba 容器提供以下特性：

- **SMB/CIFS 文件共享**：支持跨异构平台的高性能网络文件共享服务。
- **标准化 Dockerfile**：遵循 OCI 规范与容器最佳实践。
- **灵活的 Entrypoint 机制**：支持自定义初始化脚本扩展。
- **一致的环境变量体系**：多发行版保持统一的环境变量支持。
- **多架构支持**：全面支持主流硬件平台与指令集架构。
- **三种发行版版本**：Alpine（超轻量）、Debian（默认/高兼容性）、Rocky（企业级）。

## 版本信息

| 发行版 | 基础镜像 | Samba 版本 | 支持架构 |
|--------|----------|------------|----------|
| Alpine 3.24 | `snowdreamtech/alpine:3.24.1` | 4.23.10-r0 | i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x |
| Debian 13 (默认) | `snowdreamtech/debian:13.6.0` | 2:4.22.11+dfsg-0+deb13u1 | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| Rocky 10.2 | `snowdreamtech/rocky:10.2.0` | 4.23.5-111.el10_2 | amd64, arm64, ppc64le, s390x |

## 快速上手

### Docker CLI

#### 基础启动

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

#### 高级启动（挂载共享数据卷）

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

## 发行版选择

### Debian（默认版本）

适合绝大多数场景，具备优秀的兼容性与丰富的依赖支持。

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

**支持架构**：amd64, arm32v7, arm64, ppc64le, riscv64, s390x

### Alpine

轻量化镜像，专为极致资源利用与最小化体积优化。

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

**支持架构**：i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x

### Rocky

基于 Rocky Linux 的企业级版本，适用于对 RHEL 生态有生产要求的场景。

```bash
docker run -d \
  --name=samba \
  -p 139:139 \
  -p 445:445 \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:rocky
```

**支持架构**：amd64, arm64, ppc64le, s390x

## 配置与环境变量

| 变量名 | 默认值 | 描述 |
|--------|--------|------|
| `SAMBA_PASSWORD` | 自动生成 | 默认用户 `samba` 的访问密码 |
| `TZ` | `UTC` | 容器时区 |
| `DEBUG` | `false` | 是否开启详细调试日志 |
| `PUID` | `0` | 进程执行的用户 ID |
| `PGID` | `0` | 进程执行的用户组 ID |

## 许可证

本项目基于 MIT 许可证开源 - 详见 [LICENSE](LICENSE) 文件。
