# Samba

![Docker Image Version](https://img.shields.io/docker/v/snowdreamtech/samba)
![Docker Image Size](https://img.shields.io/docker/image-size/snowdreamtech/samba/latest)
![Docker Pulls](https://img.shields.io/docker/pulls/snowdreamtech/samba)
![Docker Stars](https://img.shields.io/docker/stars/snowdreamtech/samba)

Samba Docker 镜像，提供 SMB/CIFS 文件共享服务。支持多架构和多种 Linux 发行版。

## 版本信息

| 发行版 | Samba 版本 | 支持架构 |
|--------|------------|----------|
| Alpine 3.24 | 4.23.8-r0 | i386, amd64, arm32v6, arm32v7, arm64, ppc64le, riscv64, s390x |
| Debian 13 | 4.22.10 | amd64, arm32v7, arm64, ppc64le, riscv64, s390x |
| Rocky 10.2 | 4.23.5 | amd64, arm64, ppc64le, s390x |

## 概述

Samba 是一个开源的 SMB/CIFS 协议实现，允许 Linux 服务器为 Windows、macOS 和其他 Linux 机器提供文件共享服务。

## 快速开始

```bash
# 拉取并运行 Debian 变体（推荐）
docker pull snowdreamtech/samba:debian
docker run -d --name=samba -e TZ=Asia/Shanghai snowdreamtech/samba:debian

# 或使用 docker-compose
docker-compose up -d
```

## 发行版变体

### Debian（推荐）

```bash
docker run -d \
  --name=samba \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:debian
```

### Alpine（轻量级）

```bash
docker run -d \
  --name=samba \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:alpine
```

### Rocky（企业级）

```bash
docker run -d \
  --name=samba \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  snowdreamtech/samba:rocky
```

## 构建说明

### 单架构构建

```bash
# 构建 Debian 变体
docker build -t snowdreamtech/samba:debian ./docker/debian/

# 构建 Alpine 变体
docker build -t snowdreamtech/samba:alpine ./docker/alpine/

# 构建 Rocky 变体
docker build -t snowdreamtech/samba:rocky ./docker/rocky/
```

### 多架构构建

使用 `docker buildx` 为多个架构构建镜像。详见 [Development](#开发) 部分。

## Docker Compose 示例

### 简单配置

```yaml
services:
  samba:
    image: snowdreamtech/samba:debian
    container_name: samba
    environment:
      - TZ=Asia/Shanghai
    restart: unless-stopped
```

### 高级配置

```yaml
services:
  samba:
    image: snowdreamtech/samba:debian
    container_name: samba
    environment:
      - TZ=Asia/Shanghai
    volumes:
      - /path/to/data:/data
    restart: unless-stopped
```

## 环境变量

| 变量 | 默认值 | 描述 |
|----------|---------|-------------|
| `TZ` | - | 时区（例如 `Asia/Shanghai`）|
| `SAMBA_PASSWORD` | 随机生成 | Samba 用户密码 |
| `DEBUG` | `false` | 启用调试输出 |

## 语义化版本标签

- `snowdreamtech/samba:alpine-<version>`
- `snowdreamtech/samba:debian-<version>`
- `snowdreamtech/samba:rocky-<version>`
- `snowdreamtech/samba:latest` (指向 Debian)

## 开发

### 前置要求

- Docker（>= 20.10）
- Docker Buildx 插件

### 本地构建

```bash
# 构建特定变体
docker build -t samba:debian ./docker/debian/
docker build -t samba:alpine ./docker/alpine/
docker build -t samba:rocky ./docker/rocky/
```

## 参考资料

1. [使用 buildx 构建多平台 Docker 镜像](https://icloudnative.io/posts/multiarch-docker-with-buildx/)
2. [如何使用 docker buildx 构建跨平台 Go 镜像](https://waynerv.com/posts/building-multi-architecture-images-with-docker-buildx/#buildx-%E7%9A%84%E8%B7%A8%E5%B9%B3%E5%8F%B0%E6%9E%84%E5%BB%BA%E7%AD%96%E7%95%A5)
3. [Building Multi-Arch Images for Arm and x86 with Docker Desktop](https://www.docker.com/blog/multi-arch-images/)
4. [How to Rapidly Build Multi-Architecture Images with Buildx](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/)
5. [Faster Multi-Platform Builds: Dockerfile Cross-Compilation Guide](https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/)
6. [docker/buildx](https://github.com/docker/buildx)

## 联系方式（备注：samba）

* Email: <sn0wdr1am@qq.com>
* QQ: 3217680847
* QQ群: 949022145
* WeChat/微信群: sn0wdr1am

## 许可证

MIT
