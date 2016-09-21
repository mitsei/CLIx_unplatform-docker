FROM django:onbuild
MAINTAINER alpesh "alpesh@tiss.edu"

RUN git clone https://0d69830ad6630f0d3cecba389f50755807f27742@github.com/CLIxIndia-Dev/Unplatform.git 
RUN cp -r Unplatform/unplatform_source/* .
RUN rm -rf Unplatform
RUN touch debug.log && chown www-data.www-data debug.log


RUN apt-get update && apt-get install -y supervisor apache2 libapache2-mod-wsgi-py3

ADD ./wsgi.py /usr/src/app/unplatform/wsgi.py
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./supervisord.conf /etc/supervisord.conf



ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
