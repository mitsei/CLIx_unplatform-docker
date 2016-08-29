FROM django:onbuild
MAINTAINER alpesh "alpesh@tiss.edu"

ENV SYNCTHING_VERSION 0.14.5


WORKDIR /srv
RUN useradd --no-create-home -g users syncthing
RUN curl -L -o syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz \
  && tar -xzvf syncthing.tar.gz \
  && rm -f syncthing.tar.gz \
  && mv syncthing-linux-amd64-v* syncthing \
  && rm -rf syncthing/etc \
  && rm -rf syncthing/*.pdf \
  && mkdir -p /srv/config \
  && mkdir -p /srv/data

RUN apt-get update && apt-get install -y supervisor apache2 libapache2-mod-wsgi-py3


RUN bash /usr/src/app/start.sh
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./supervisord.conf /etc/supervisord.conf


ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
