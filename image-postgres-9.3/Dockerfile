# Use fedora 22 image as the base
FROM fedora:22
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>


ENV PGDATA /var/lib/pgsql/9.3/data

RUN  echo "root:redhat1!" | /usr/sbin/chpasswd \
 && groupadd -r postgres \
 && useradd -r -g postgres postgres \
 && rpm -iUvh http://yum.postgresql.org/9.3/fedora/fedora-22-x86_64/pgdg-fedora93-9.3-2.noarch.rpm \
# Execute system update
 && dnf -y update \
# Install some necessary packages \
 && dnf -y install which unzip sudo wget tar findutils initscripts \
 # Install postgresql
 && dnf -y install postgresql93 postgresql93-server postgresql93-contrib postgresql93-libs --enablerepo=pgdg93 \
# && echo clean cache \
 && dnf clean all

ADD . /tmp/host
RUN chmod -R 777 /tmp/host

 ########################
 # Postgres for JON Config
 #######################
RUN  echo PGDATA=$PGDATA > /etc/sysconfig/pgsql/postgresql-9.3 \
 && /usr/pgsql-9.3/bin/postgresql93-setup initdb \
 && echo "listen_addresses='*'" >> $PGDATA/postgresql.conf \
 && echo "" >> $PGDATA/postgresql.conf \
 #Set a home directory for postgres user
 && mkdir -p /home/postgres \
 && cp /tmp/host/support/startDBandLoop.sh /home/postgres \
 && chown -R postgres:postgres /home/postgres



#############################################
# Create database 
#############################################
USER postgres
WORKDIR /home/postgres

ENV PGDATA /var/lib/pgsql/9.3/data

RUN /usr/pgsql-9.3/bin/pg_ctl start -w -D $PGDATA  \
 && /usr/pgsql-9.3/bin/psql --command "ALTER USER postgres PASSWORD 'postgres';" \
 && /usr/pgsql-9.3/bin/pg_ctl stop  -D $PGDATA

VOLUME /var/lib/postgresql/data
USER root
RUN   cp /tmp/host/support/pg_hba.conf $PGDATA/pg_hba.conf \
 && chown postgres:postgres /var/lib/pgsql/9.3/data/pg_hba.conf \
 && rm -r /tmp/host/*

USER postgres

CMD /home/postgres/startDBandLoop.sh

EXPOSE 5432 22
