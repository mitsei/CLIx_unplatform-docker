FROM django:onbuild
MAINTAINER alpesh "alpesh@tiss.edu"

RUN git clone https://743e4ddc106b7b2cf402bbf802cae683b0aa62de@github.com/CLIxIndia-Dev/Unplatform.git 
RUN cp -r Unplatform/unplatform_source/* .
RUN rm -rf Unplatform
RUN touch debug.log && chown www-data.www-data debug.log


RUN apt-get update && apt-get install -y supervisor apache2 libapache2-mod-wsgi-py3

ADD ./wsgi.py /usr/src/app/unplatform/wsgi.py
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./supervisord.conf /etc/supervisord.conf



ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
