#!/bin/sh
set -e

# start syslog so daemons have somewhere to log
syslogd -n -O /proc/1/fd/1 2>/dev/null &

# persist crontabs on the named volume
mkdir -p /root/crontabs
[ -f /root/crontabs/root ] || cp /etc/crontabs/root /root/crontabs/root 2>/dev/null || true

# start cron (kill stale instance first to avoid duplicates on restart)
pkill crond 2>/dev/null || true
crond -b -l 8 -c /root/crontabs

# run user-defined autostart scripts (replaces systemctl enable)
# stored in /root/.local.d/ so they persist on the named volume across docker rm
for f in /root/.local.d/*.start; do
    [ -f "$f" ] && sh "$f" || true
done

# hand off — tini reaps zombies, sleep keeps container alive
exec sleep infinity
