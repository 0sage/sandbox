# sandbox

VM-like sandbox container images for isolated environments.

## Images

| Image | Base | Description |
|-------|------|-------------|
| [debiand](debiand/) | Debian Bookworm | systemd as PID 1, cron, full VM-like environment |
| [alpined](alpined/) | Alpine 3.20 | tini as PID 1, crond, daemon autostart hooks |

## Run a sandbox

### alpined

```bash
NAME=mybox

docker run -d \
  --name $NAME \
  --hostname $NAME \
  --restart=unless-stopped \
  -v ${NAME}-home:/home \
  -v ${NAME}-root:/root \
  ghcr.io/0sage/alpined:latest
```

### debiand (systemd)

```bash
NAME=mybox

docker run -d \
  --name $NAME \
  --hostname $NAME \
  --restart=unless-stopped \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v ${NAME}-data:/home \
  ghcr.io/0sage/debiand:latest
```

## Enter

```bash
docker exec -it $NAME bash
```

## Resource limits

Optional — add at run time if needed:

```bash
--cpus=1 --memory=512m --memory-swap=512m
```

## Install and run daemons (alpined)

Packages installed with `apk` persist in the container's writable layer across restarts:

```bash
docker exec -it $NAME bash
apk add --no-cache nanobot
```

To auto-start a daemon on every container restart, drop a shell script into `/root/.local.d/`:

```bash
docker exec $NAME sh -c 'printf "#!/bin/sh\nnanobot gateway &\n" > /root/.local.d/nanobot.start'
docker restart $NAME
```

The entrypoint sources all `*.start` files in `/root/.local.d/` on boot. This is the `systemctl enable` equivalent for alpined.

## Persist data

`/home` and `/root` are named volumes — persist across restarts and survive `docker rm` unless you run `docker rm -v <name>` or `docker volume prune`. The container writable layer (installed packages, config files) persists across `stop`/`start`/`restart` but is lost on `docker rm`.

## Manage lifecycle

```bash
docker stop $NAME
docker start $NAME
docker restart $NAME
docker rm $NAME             # delete container (writable layer lost, volume kept)
docker rm -v $NAME          # delete container and volume
```
