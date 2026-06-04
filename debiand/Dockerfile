FROM debian:bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    systemd \
    systemd-sysv \
    dbus \
    iproute2 \
    iputils-ping \
    curl \
    wget \
    sudo \
    openssh-client \
    procps \
    cron \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f \
    /lib/systemd/system/multi-user.target.wants/getty* \
    /lib/systemd/system/multi-user.target.wants/systemd-logind.service \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/syslog.socket \
    /lib/systemd/system/systemd-update-utmp* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup-dev* \
    && systemctl enable cron \
    && mkdir -p /etc/systemd/system.conf.d \
    && printf '[Manager]\nDefaultEnvironment=HOME=/root USER=root LOGNAME=root SHELL=/bin/bash LANG=C.UTF-8 TERM=xterm-256color XDG_RUNTIME_DIR=/run/user/0\n' \
       > /etc/systemd/system.conf.d/env.conf

STOPSIGNAL SIGRTMIN+3

ENV PATH="/root/.local/bin:$PATH"

CMD ["/lib/systemd/systemd"]
