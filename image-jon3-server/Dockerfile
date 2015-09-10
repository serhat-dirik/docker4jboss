# Use postgres image as a base
FROM docker4jboss/postgres-9
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

USER root
# Create a user and group used to launch processes
RUN groupadd -r jboss  && useradd -r -g jboss -G postgres -m -d /opt/jboss -c "JBoss user" jboss \
 && chmod 755 /opt/jboss \
 && mkdir /opt/jboss/jon \
 && chown -R jboss:jboss /opt/jboss \
# Update Sudoers
 && echo 'jboss ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV JAVA_HOME /usr/lib/jvm/java
#Add local sources
ADD . /tmp/host
RUN chmod -R 777 /tmp/host

# Setup Postgres for RHQ DB
USER postgres
ENV PGDATA /var/lib/pgsql/9.3/data
ENV PGPASSWORD postgres

RUN /usr/pgsql-9.3/bin/pg_ctl start -w -D $PGDATA \
 && /usr/pgsql-9.3/bin/psql --command "CREATE USER rhqadmin PASSWORD 'rhqadmin';"\
 && /usr/pgsql-9.3/bin/psql --command "CREATE DATABASE rhq OWNER rhqadmin;" \
 && /usr/pgsql-9.3/bin/pg_ctl stop -w -D $PGDATA

# Switch jboss to install JON
USER jboss
# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss
# Java home
ENV JAVA_HOME /usr/lib/jvm/java

ENV RHQ_JAVA_HOME $JAVA_HOME

RUN unzip /tmp/host/install/jon-server-3.3.0.GA.zip -d $HOME/jon \
 && unzip /tmp/host/install/jon-plugin-pack-ews-3.3.0.GA.zip -d $HOME/jon/jon-server-3.3.0.GA/plugins \
 && cp -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-ews-3.3.0.GA/*.jar $HOME/jon/jon-server-3.3.0.GA/plugins \
 && rm -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-ews-3.3.0.GA \
 && unzip /tmp/host/install/jon-plugin-pack-eap-3.3.0.GA.zip -d $HOME/jon/jon-server-3.3.0.GA/plugins \
 && cp -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-eap-3.3.0.GA/*.jar $HOME/jon/jon-server-3.3.0.GA/plugins \
 && rm -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-eap-3.3.0.GA \
 && unzip /tmp/host/install/jon-plugin-pack-brms-bpms-3.3.0.GA.zip -d $HOME/jon/jon-server-3.3.0.GA/plugins \
 && cp -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-brms-bpms-3.3.0.GA/*.jar $HOME/jon/jon-server-3.3.0.GA/plugins \
 && rm -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-brms-bpms-3.3.0.GA \
 && unzip /tmp/host/install/jon-plugin-pack-datavirtualization-3.3.0.GA.zip -d $HOME/jon/jon-server-3.3.0.GA/plugins \
 && cp -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-datavirtualization-3.3.0.GA/*.jar $HOME/jon/jon-server-3.3.0.GA/plugins \
 && rm -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-datavirtualization-3.3.0.GA \
 && unzip /tmp/host/install/jon-plugin-pack-fuse-3.3.0.GA.zip -d $HOME/jon/jon-server-3.3.0.GA/plugins \
 && cp -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-fuse-3.3.0.GA/*.jar $HOME/jon/jon-server-3.3.0.GA/plugins \
 && rm -r $HOME/jon/jon-server-3.3.0.GA/plugins/jon-plugin-pack-fuse-3.3.0.GA \
 # Config
 && cp $HOME/jon/jon-server-3.3.0.GA/bin/rhq-server.properties $HOME/jon/jon-server-3.3.0.GA/bin/rhq-server.properties.orig \
 && cp /tmp/host/support/rhq-server.properties $HOME/jon/jon-server-3.3.0.GA/bin/rhq-server.properties \
 && cp /tmp/host/support/startJON.sh $HOME/jon \
 && chmod +x $HOME/jon/*.sh \
 && mkdir $HOME/jon-update \
 && unzip /tmp/host/install/jon-server-3.3-update-03.zip -d $HOME/jon-update


# Switch back to root to clean environment
USER root
#Clean Up
RUN rm -r /tmp/host/*

CMD /opt/jboss/jon/startJON.sh

EXPOSE 5432 7080 7443 16163 9142 7299 7100 25 22
