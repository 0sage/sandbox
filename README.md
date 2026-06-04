# sandbox

VM-like sandbox container images for isolated environments.

## Images

| Image | Base | Description |
|-------|------|-------------|
| [debiand](debiand/) | Debian Bookworm | systemd as PID 1, cron, full VM-like environment |

## Run a sandbox

```bash
docker run -d \
  --name <name> \
  --hostname <name> \
  --restart=unless-stopped \
  --cpus=1 \
  --memory=512m \
  --memory-swap=512m \
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

## Resource limits

Default: 1 CPU, 512MB RAM. Override at run time:

```bash
--cpus=2 --memory=2g --memory-swap=2g
```

## Persist data

The `/home` volume persists across restarts. The container writable layer (installed packages, configs, systemd services) also persists as long as the container is not removed (`docker rm`).

To back up state:

```bash
# commit current state to a new image
docker commit <name> <name>-backup
```

## Manage lifecycle

```bash
docker stop <name>      # stop (data preserved)
docker start <name>     # start again
docker restart <name>   # restart (all services auto-start via systemd)
docker rm <name>        # delete container (writable layer lost, /home volume kept)
docker volume rm <name>-data  # delete persistent data
```
