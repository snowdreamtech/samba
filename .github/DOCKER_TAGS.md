# Docker Image Tags Reference

This document describes the Docker image tagging strategy for the samba project.

## Tag Naming Convention

All images use the format: `snowdreamtech/samba:TAG`

Where `TAG` follows these patterns:

- **Variant-specific tags**: `TAG-variant` (e.g., `nightly-alpine`, `4.23.10-alpine`)
- **Default tags** (Debian only): `TAG` (e.g., `nightly`, `latest`, `4.22.11`)

## Supported Registries

All tags are pushed to two registries:

- **DockerHub**: `snowdreamtech/samba:TAG`
- **GitHub Container Registry**: `ghcr.io/snowdreamtech/samba:TAG`

## Tag Scenarios

### 1. Branch Builds (dev/main)

#### Push to `dev` branch

```bash
git push origin dev
```

**Generated tags:**

```
snowdreamtech/samba:dev-alpine
snowdreamtech/samba:dev-debian
snowdreamtech/samba:dev              # ← Debian (default)
snowdreamtech/samba:dev-rocky
```

#### Push to `main` branch

```bash
git push origin main
```

**Generated tags:**

```
snowdreamtech/samba:main-alpine
snowdreamtech/samba:latest-alpine
snowdreamtech/samba:main-debian
snowdreamtech/samba:latest-debian
snowdreamtech/samba:main             # ← Debian (default)
snowdreamtech/samba:latest           # ← Debian (default)
snowdreamtech/samba:main-rocky
snowdreamtech/samba:latest-rocky
```

---

### 2. Version Release Tags (Release Please)

When Release Please creates and tags a release:

#### Alpine Release (e.g., `alpine-v4.23.10`)

```bash
git tag alpine-v4.23.10
git push origin alpine-v4.23.10
```

**Generated tags:**

```
snowdreamtech/samba:4.23.10-alpine
snowdreamtech/samba:4.23-alpine
snowdreamtech/samba:4-alpine
snowdreamtech/samba:latest-alpine
```

#### Debian Release (e.g., `debian-v4.22.11`) - Default Variant

```bash
git tag debian-v4.22.11
git push origin debian-v4.22.11
```

**Generated tags:**

```
# Variant-suffixed tags
snowdreamtech/samba:4.22.11-debian
snowdreamtech/samba:4.22-debian
snowdreamtech/samba:4-debian
snowdreamtech/samba:latest-debian

# Unsuffixed default tags (only for Debian)
snowdreamtech/samba:4.22.11
snowdreamtech/samba:4.22
snowdreamtech/samba:4
snowdreamtech/samba:latest
```

#### Rocky Release (e.g., `rocky-v4.23.5`)

```bash
git tag rocky-v4.23.5
git push origin rocky-v4.23.5
```

**Generated tags:**

```
snowdreamtech/samba:4.23.5-rocky
snowdreamtech/samba:4.23-rocky
snowdreamtech/samba:4-rocky
snowdreamtech/samba:latest-rocky
```

---

### 3. Nightly Builds (Scheduled)

Runs daily at 17:00 UTC via GitHub Actions schedule:

**Generated tags:**

```
snowdreamtech/samba:nightly-alpine
snowdreamtech/samba:nightly-debian
snowdreamtech/samba:nightly          # ← Debian (default)
snowdreamtech/samba:nightly-rocky
```

---

## Quick Reference Table

| Trigger | Alpine Tags | Debian Tags (Default) | Rocky Tags |
|---------|-------------|----------------------|------------|
| `git push origin dev` | `dev-alpine` | `dev-debian`, `dev` | `dev-rocky` |
| `git push origin main` | `main-alpine`, `latest-alpine` | `main-debian`, `latest-debian`, `main`, `latest` | `main-rocky`, `latest-rocky` |
| Tag `alpine-v4.23.10` | `4.23.10-alpine`, `4.23-alpine`, `4-alpine`, `latest-alpine` | — | — |
| Tag `debian-v4.22.11` | — | `4.22.11-debian`, `4.22-debian`, `4-debian`, `latest-debian`, `4.22.11`, `4.22`, `4`, `latest` | — |
| Tag `rocky-v4.23.5` | — | — | `4.23.5-rocky`, `4.23-rocky`, `4-rocky`, `latest-rocky` |
| Scheduled (Daily) | `nightly-alpine` | `nightly-debian`, `nightly` | `nightly-rocky` |

---

## Pull Examples

### Latest Stable Releases

```bash
# Latest Debian (default)
docker pull snowdreamtech/samba:latest
docker pull snowdreamtech/samba:debian

# Latest Alpine
docker pull snowdreamtech/samba:latest-alpine
docker pull snowdreamtech/samba:alpine

# Latest Rocky
docker pull snowdreamtech/samba:latest-rocky
docker pull snowdreamtech/samba:rocky
```

### Specific Versions

```bash
# Specific version with variant
docker pull snowdreamtech/samba:4.23.10-alpine
docker pull snowdreamtech/samba:4.22.11-debian
docker pull snowdreamtech/samba:4.23.5-rocky

# Specific version (Debian default, unsuffixed)
docker pull snowdreamtech/samba:4.22.11
docker pull snowdreamtech/samba:4.22
docker pull snowdreamtech/samba:4
```

### Development Builds

```bash
# Dev branch
docker pull snowdreamtech/samba:dev
docker pull snowdreamtech/samba:dev-alpine
docker pull snowdreamtech/samba:dev-debian
docker pull snowdreamtech/samba:dev-rocky
```

### Nightly Builds

```bash
# Alpine nightly
docker pull snowdreamtech/samba:nightly-alpine

# Debian nightly (two ways)
docker pull snowdreamtech/samba:nightly-debian
docker pull snowdreamtech/samba:nightly

# Rocky nightly
docker pull snowdreamtech/samba:nightly-rocky
```

---

## Tag Lifecycle

### Development Flow

```
1. Push to dev → samba:dev-alpine, samba:dev-debian, samba:dev, samba:dev-rocky
2. Push to main → samba:main-alpine, samba:latest-alpine, samba:main-debian, samba:latest-debian, samba:main, samba:latest, samba:main-rocky, samba:latest-rocky
3. Create tag → samba:VERSION-variant, samba:latest-variant (+ unsuffixed for Debian)
```

### Release Flow (with Release Please)

```
1. Merge PR to main → Release Please creates release PR
2. Merge release PR → Release Please creates tags (alpine-vX.Y.Z, debian-vX.Y.Z, rocky-vX.Y.Z)
3. Tag push triggers build → Images published with version tags
```

---

## Matrix Configuration

The workflow uses a matrix strategy with three variants:

```yaml
matrix:
  include:
    - variant: alpine
      version: "4.23.10"
      is_latest: false

    - variant: debian
      version: "4.22.11"
      is_latest: true    # ← Default variant

    - variant: rocky
      version: "4.23.5"
      is_latest: false
```

Only the variant with `is_latest: true` receives unsuffixed tags.

---

## Metadata Action Configuration

The key configuration that enables this tagging strategy:

```yaml
images: |
  name=ghcr.io/snowdreamtech/samba,enable=true
  name=snowdreamtech/samba,enable=true
flavor: |
  latest=false
  prefix=
  suffix=-${{ matrix.variant }}  # ← Adds variant suffix to all tags
```

For Debian (is_latest), additional rules generate unsuffixed tags:

```yaml
type=raw,enable=${{ matrix.is_latest }},priority=1000,prefix=,suffix=,pattern=nightly
```

This creates both `nightly-debian` (from flavor suffix) and `nightly` (from this rule).
