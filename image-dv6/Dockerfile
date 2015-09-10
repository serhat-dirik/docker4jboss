# Use postgres image as a base
FROM docker4jboss/base
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

USER root

RUN  dnf install -y java-1.8.0-openjdk-devel \
 # && echo clean cache \
 && dnf clean all \
 # Create a user and group used to launch processes
 && groupadd -r jboss  && useradd -r -g jboss -m -d /opt/jboss -c "JBoss user" jboss \
 && chmod 755 /opt/jboss \
 && chown -R jboss:jboss /opt/jboss \
 # Update Sudoers
 && echo 'jboss ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV JAVA_HOME /usr/lib/jvm/java
#Add local sources
ADD . /tmp/host
RUN chmod -R 777 /tmp/host
############################################
# Install JBoss Data Virtualization 6.1.0.GA
############################################
USER jboss
# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss
# Java home
ENV JAVA_HOME /usr/lib/jvm/java

RUN mkdir /opt/jboss/dv \
  && cp /tmp/host/support/*.sh /opt/jboss \
  && java -jar /tmp/host/install/jboss-dv-installer-6.1.0.redhat-3.jar /tmp/host/support/installscript.xml \
  && /opt/jboss/dv/jboss-eap-6.3/bin/jboss-cli.sh --command="patch apply /tmp/host/install/BZ-1185069.zip --override-all" \
  && /opt/jboss/dv/jboss-eap-6.3/bin/jboss-cli.sh --command="patch apply /tmp/host/install/BZ-1213582.zip --override-all" \
  && cp /tmp/host/install/*.war /opt/jboss/dv/jboss-eap-6.3/standalone/deployments \
  && rm -rf /opt/jboss/dv/jboss-eap-6.3/standalone/configuration/standalone_xml_history/current

# JBoss Home
ENV JBOSS_HOME /opt/jboss/dv/jboss-eap-6.3
ENV RHQ_JAVA_HOME $JAVA_HOME
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
# Switch back to root to clean environment
USER root
#Clean Up
RUN rm -r /tmp/host/*

CMD /opt/jboss/startDV.sh
EXPOSE 80 5432 3306 27017 31000 6666 8009 8080 8787 8443 3528 3529 7500 45700/udp 9876/udp 23364/udp 7600 57600 55200/udp 45688/udp 54200/udp 5445 8090 4417 4712 4713 9990 9999 7080 16163 25 22
