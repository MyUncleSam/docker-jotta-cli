FROM ubuntu:20.04
LABEL maintainer="Stefan Ruepp <stefan@ruepp.info>"
LABEL github="https://github.com/MyUncleSam/docker-jotta-cli/"

ENV TZ=Europe/Berlin

RUN apt-get update \
    && apt-get install --no-install-recommends -y wget apt-transport-https ca-certificates gnupg2 tzdata \
    && chmod u+x /root/start.sh \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata \
    && wget -O - https://repo.jotta.us/public.gpg | apt-key add - \
    && echo "deb https://repo.jotta.us/debian debian main" | tee /etc/apt/sources.list.d/jotta-cli.list

RUN apt-get update \
    && apt-get install -y jotta-cli \
    && service jottad stop \
    && update-rc.d jottad disable \
    && update-rc.d jottad remove \
    && apt-get autoclean -y && apt-get clean -y && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

VOLUME [ "/var/lib/jottad" ]
ENTRYPOINT [ "/usr/bin/jottad" ]