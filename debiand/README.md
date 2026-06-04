# debiand

Debian Bookworm with systemd as PID 1. Designed as a VM-like sandbox container.

## Features

- systemd as PID 1 — install and manage daemons with `systemctl`
- cron enabled by default
- Proper environment for system services (`HOME`, `USER`, `SHELL`, `TERM`, `LANG`)
- `ca-certificates` included for SSL/TLS

## Run

```bash
docker run -d \
  --name <name> \
  --hostname <name> \
  --restart=unless-stopped \
  --cap-add SYS_ADMIN \
  --cap-add NET_ADMIN \
  --cap-add SYS_PTRACE \
  --security-opt seccomp=unconfined \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v <name>-data:/home \
  ghcr.io/0sage/debiand:latest
```

## Enter

```bash
docker exec -it <name> bash
```
