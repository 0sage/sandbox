# sandbox

VM-like sandbox container images for isolated environments.

## Images

| Image | Base | Description |
|-------|------|-------------|
| [debiand](debiand/) | Debian Bookworm | systemd as PID 1, cron, full VM-like environment |

## Run a sandbox

```bash
NAME=mybox

docker run -d \
  --name $NAME \
  --hostname $NAME \
  --restart=unless-stopped \
  --cpus=1 \
  --memory=512m \
  --memory-swap=512m \
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

Default: 1 CPU, 512MB RAM. Override at run time:

```bash
--cpus=2 --memory=2g --memory-swap=2g
```

## Persist data

`/home` is an anonymous volume — persists across restarts, survives `docker rm` unless you run `docker rm -v <name>` or `docker volume prune`.

## Manage lifecycle

```bash
docker stop $NAME
docker start $NAME
docker restart $NAME
docker rm $NAME             # delete container (writable layer lost, volume kept)
docker rm -v $NAME          # delete container and volume
```
