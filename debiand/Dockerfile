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
    && rm -rf /var/lib/apt/lists/* \
    && rm -f \
    /lib/systemd/system/multi-user.target.wants/getty* \
    /lib/systemd/system/multi-user.target.wants/systemd-logind.service \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/syslog.socket \
    /lib/systemd/system/systemd-update-utmp* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup-dev* \
    && systemctl enable cron

STOPSIGNAL SIGRTMIN+3

CMD ["/lib/systemd/systemd"]
