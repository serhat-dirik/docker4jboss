FROM docker4jboss/base
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>


ENV PGDATA /var/lib/pgsql/9.3/data

RUN  groupadd -r postgres \
 && useradd -r -g postgres postgres \
 && echo 'postgres ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
 && dnf -y install java-1.8.0-openjdk-devel \
 && rpm -iUvh http://yum.postgresql.org/9.3/fedora/fedora-22-x86_64/pgdg-fedora93-9.3-2.noarch.rpm \
 # Install postgresql
 && dnf -y install postgresql93 postgresql93-server postgresql93-contrib postgresql93-libs --enablerepo=pgdg93 \
# clean cache \
 && dnf clean all

ENV JAVA_HOME /usr/lib/jvm/java
ADD . /tmp/host
RUN chmod -R 777 /tmp/host

 ########################
 # Postgres Config
 #######################
RUN  echo PGDATA=$PGDATA > /etc/sysconfig/pgsql/postgresql-9.3 \
 && /usr/pgsql-9.3/bin/postgresql93-setup initdb \
 && echo "listen_addresses='*'" >> $PGDATA/postgresql.conf \
 && echo "" >> $PGDATA/postgresql.conf \
 #Set a home directory for postgres user
 && mkdir -p /home/postgres \
 && cp /tmp/host/support/startDBandLoop*.sh /home/postgres \
 && chown -R postgres:postgres /home/postgres


USER postgres
WORKDIR /home/postgres
ENV JAVA_HOME /usr/lib/jvm/java
ENV RHQ_JAVA_HOME $JAVA_HOME
ENV PGDATA /var/lib/pgsql/9.3/data
#############################################
# Create database
#############################################
RUN /usr/pgsql-9.3/bin/pg_ctl start -w -D $PGDATA  \
 && /usr/pgsql-9.3/bin/psql --command "ALTER USER postgres PASSWORD 'postgres';" \
 && /usr/pgsql-9.3/bin/pg_ctl stop  -D $PGDATA
 ##############################################
 # Unzip JON Agent install files
 ##############################################
 RUN mkdir $HOME/jon \
  && java -jar /tmp/host/install/rhq-enterprise-agent*.jar --install=$HOME/jon \
 # Update
  && mkdir $HOME/jon-update \
  && unzip /tmp/host/install/jon-server-3.3-update-03.zip -d $HOME/jon-update \
  && $HOME/jon-update/jon-server-3.3.0.GA-update-03/apply-updates.sh $HOME/jon/rhq-agent/ \
  && cp /tmp/host/support/agent-configuration.xml $HOME/jon/rhq-agent/conf

USER root
RUN   cp /tmp/host/support/pg_hba.conf $PGDATA/pg_hba.conf \
 && chown postgres:postgres /var/lib/pgsql/9.3/data/pg_hba.conf \
 && rm -r /tmp/host/*

USER postgres
ENV PATH "$PATH:/usr/pgsql-9.3/bin"
VOLUME ["/var/lib/postgresql/data","/home/postgres/jon/rhq-agent/conf"]
CMD /home/postgres/startDBandLoop.sh

EXPOSE 5432 22
