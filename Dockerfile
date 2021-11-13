FROM debian:11.1-slim

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        bzip2 \
        aptly \
        gnupg2 \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=root:root rootfs/. /.
VOLUME [ "/data/deb-root" ]

WORKDIR /data/deb-root

EXPOSE 5003
CMD [ "/bin/sh", "/entrypoint" ]
