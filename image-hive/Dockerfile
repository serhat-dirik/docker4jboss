FROM docker4jboss/hadoop

# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>
#Based on hadoop2
#Configure Postgres DB
#Starts Hive metastore Server
#Starts Hive Server

ENV PGDATA /var/lib/pgsql/9.3/data

RUN  groupadd -r postgres \
 && useradd -r -g postgres postgres \
 && echo 'postgres ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
 && rpm -iUvh http://yum.postgresql.org/9.3/fedora/fedora-22-x86_64/pgdg-fedora93-9.3-2.noarch.rpm \
 # Install postgresql
 && dnf -y install postgresql93 postgresql93-server postgresql93-contrib postgresql93-libs postgresql-jdbc --enablerepo=pgdg93 \
 && dnf clean all


########################
# Postgres Config
#######################
RUN  echo PGDATA=$PGDATA > /etc/sysconfig/pgsql/postgresql-9.3 \
 && /usr/pgsql-9.3/bin/postgresql93-setup initdb \
 && echo "listen_addresses='*'" >> $PGDATA/postgresql.conf \
 && echo "" >> $PGDATA/postgresql.conf \
 #Set a home directory for postgres user
 && mkdir -p /home/postgres \
 && chown -R postgres:postgres /home/postgres

# set hive environment
ENV HIVE_VERSION 1.2.1
ENV HIVE_HOME /opt/hive
ENV HIVE_CONF $HIVE_HOME/conf
ENV PATH $HIVE_HOME/bin:$PATH

# to avoid psql asking password, set PGPASSWORD



RUN curl -s http://www.us.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz | tar -xz -C /opt \
 && ln -s /opt/apache-hive-${HIVE_VERSION}-bin /opt/hive

ADD ./support /tmp/host/support
RUN chmod -R 777 /tmp/host


RUN  ln -s /usr/share/java/postgresql-*.jar $HIVE_HOME/lib/. \
 && cp /tmp/host/support/hive-site.xml $HIVE_CONF \
 && cp /tmp/host/support/hive-log4j.properties $HIVE_CONF \
 && mv /tmp/host/support/store_sales* /tmp \
 && mkdir -p /opt/hive/data/operation_logs \
 && mkdir -p /opt/hive/data/scratchdir \
 && mkdir -p /opt/hive/data/downloaded \
 && mkdir -p /opt/hive/data/querylog \
 && chown -R root:root /opt/apache-hive-${HIVE_VERSION}-bin/* \
 && chown -R root:root /opt/hive/*

ENV CLASSPATH $CLASSPATH:/opt/hadoop/lib/*:/opt/hive/lib/*:.

ENV PATH $PATH:/opt/hive/bin

USER postgres
WORKDIR /home/postgres
ENV JAVA_HOME /usr/lib/jvm/java
ENV PGDATA /var/lib/pgsql/9.3/data
 #ENV PGPASSWORD postgres
#############################################
# Create database
#############################################
RUN /usr/pgsql-9.3/bin/pg_ctl start -w -D $PGDATA  \
 && /usr/pgsql-9.3/bin/psql --command "ALTER USER postgres PASSWORD 'postgres';" \
 && /usr/pgsql-9.3/bin/psql --command "CREATE DATABASE metastore WITH OWNER postgres;" \
 && /usr/pgsql-9.3/bin/psql --command "GRANT ALL PRIVILEGES ON DATABASE metastore TO postgres;" \
 && /usr/pgsql-9.3/bin/psql -a  -d metastore -f /opt/hive/scripts/metastore/upgrade/postgres/hive-schema-1.2.0.postgres.sql \
 && /usr/pgsql-9.3/bin/psql -a -d metastore -f /opt/hive/scripts/metastore/upgrade/postgres/hive-txn-schema-0.13.0.postgres.sql \
 && /usr/pgsql-9.3/bin/pg_ctl stop  -D $PGDATA


###################################################
USER root

RUN cp /tmp/host/support/startHiveContainer.sh /usr/bin \
 && cp /tmp/host/support/pg_hba.conf /var/lib/pgsql/9.3/data/pg_hba.conf \
 && chown postgres:postgres /var/lib/pgsql/9.3/data/pg_hba.conf \
 && echo "listen_addresses='*'" >> /var/lib/pgsql/9.3/data/postgresql.conf \
 && echo "" >> /var/lib/pgsql/9.3/data/postgresql.conf \
 && echo 'export PATH=$PATH:/opt/hive/bin' >> /root/.bashrc \
 && echo 'export HIVE_VERSION=1.2.1' >> /root/.bashrc \
 && echo 'export HIVE_HOME=/opt/hive'  >> /root/.bashrc\
 && echo 'export HIVE_CONF=/opt/hive/conf'  >> /root/.bashrc\
 && echo 'export HIVE_CONF_DIR=/opt/hive/conf'  >> /root/.bashrc\
 && rm -rf /tmp/host

CMD /usr/bin/startHiveContainer.sh

EXPOSE 5432 53325 8042 9999 2181 10001 10000 50010 50020 50030 50060 50070 50075 50090 50105 19888 8030 8031 8032 8033 8040 8042 8088 8080 49707 22 2122 9000 9001
