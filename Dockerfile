FROM ubuntu:20.04
LABEL maintainer="Stefan Ruepp <stefan@ruepp.info>"
LABEL github="https://github.com/MyUncleSam/docker-jotta-cli/"

ENV TZ=Europe/Berlin

ADD ./start /root/start.sh
RUN apt-get update \
    && apt-get install -y wget apt-transport-https ca-certificates gnupg2 tzdata \
    && ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata \
    && chmod u+x /root/start.sh \
    && wget -O - https://repo.jotta.us/public.gpg | apt-key add -

ADD ./jotta-cli.list /etc/apt/sources.list.d/jotta-cli.list
RUN apt-get update \
    && apt-get install -y jotta-cli \
    && service jottad stop \
    && update-rc.d jottad disable

VOLUME [ "/var/lib/jottad" ]
ENTRYPOINT [ "/root/start.sh" ]