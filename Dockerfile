FROM ubuntu:20.04

ARG BUILD_VERSION

LABEL maintainer="Stefan Ruepp <stefan@ruepp.info>"
LABEL github="https://github.com/MyUncleSam/docker-jotta-cli/"

ENV TZ=Europe/Berlin
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --no-install-recommends -y wget apt-transport-https ca-certificates gnupg2 tzdata \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata \
    && wget -O /tmp/jotta-cli.deb https://repo.jotta.us/debian/pool/main/j/jotta-cli/jotta-cli_"$BUILD_VERSION"_amd64.deb \
    && apt-get install -y /tmp/jotta-cli.deb \
    && rm -f /tmp/jotta-cli.deb \
    && update-rc.d jottad remove \
    && apt-get autoclean -y && apt-get clean -y && apt-get autoremove -y

VOLUME [ "/root/.jottad" ]
ENTRYPOINT [ "/usr/bin/jottad" ]