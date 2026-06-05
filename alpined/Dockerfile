FROM alpine:3.20

RUN apk add --no-cache \
    tini \
    bash \
    curl \
    wget \
    sudo \
    openssh-client \
    procps \
    busybox-extras \
    tzdata \
    ca-certificates

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PATH="/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ENV TERM=xterm-256color
ENV LANG=C.UTF-8

VOLUME ["/home", "/root"]

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]
