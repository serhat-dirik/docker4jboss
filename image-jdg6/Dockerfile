# Use fedora 22 image as the base
FROM docker-registry.usersys.redhat.com/docker4jboss/base

# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

# Maven version
ENV MAVEN_VERSION 3.3.9
RUN  dnf -y install java-1.8.0-openjdk-devel \
# && echo clean cache \
 && dnf clean all \
#Install Maven
 && curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
 # Update Sudoers
 && echo 'jboss ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ENV JAVA_HOME /usr/lib/jvm/java
# Maven home
ENV M2_HOME /usr/share/maven

ADD . /tmp/host
RUN chmod -R 777 /tmp/host

# Create a user and group used to launch processes

RUN  groupadd -r jboss  && useradd -r -g jboss -m -d /opt/jboss -c "JBoss user" jboss \
 && chmod 755 /opt/jboss \
# Create a home for jboss
 && mkdir /opt/jboss/.m2 \
 && chown -R jboss:jboss /opt/jboss/.m2

# Specify the user which should be used to execute all commands below
USER jboss
# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss
# Java home
ENV JAVA_HOME /usr/lib/jvm/java
# Maven home
ENV M2_HOME /usr/share/maven
# JBoss Home
ENV JBOSS_HOME /opt/jboss/jdg/jboss-datagrid-6.5.1-server
ENV JDG_HOME $JBOSS_HOME
ENV RHQ_JAVA_HOME $JAVA_HOME
##############################################
# Unzip JON Agent install files
##############################################
RUN mkdir $HOME/jon \
 && java -jar /tmp/host/install/rhq-enterprise-agent*.jar --install=$HOME/jon \
# Update
 && mkdir $HOME/jon-update \
 && unzip /tmp/host/install/jon-server-3.3-update-04.zip -d $HOME/jon-update \
 && $HOME/jon-update/jon-server-3.3.0.GA-update-04/apply-updates.sh $HOME/jon/rhq-agent/ \
 && cp /tmp/host/support/agent-configuration.xml $HOME/jon/rhq-agent/conf


##############################################
# Install JDG
##############################################
RUN mkdir $HOME/jdg \
 && mkdir $HOME/tmp \
 && /usr/bin/unzip -q /tmp/host/install/jboss-datagrid-6.5.1-server.zip -d $HOME/jdg \
# Modify permissions on Maven settings file
 && cp /tmp/host/support/settings.xml /opt/jboss/.m2/settings.xml \
 && chown jboss:jboss /opt/jboss/.m2/settings.xml \
#Add admin User
 && /opt/jboss/jdg/jboss-datagrid-6.5.1-server/bin/add-user.sh admin redhat1! --silent

# Switch back to root to clean environment
USER root
#Clean Up
RUN cp /tmp/host/support/start*.sh /usr/bin \
 && cp /tmp/host/support/standalone.conf $JDG_HOME/bin \
 && cp /tmp/host/support/jboss.sh /etc/profile.d \
 && rm -r /tmp/host/* \
 && rm -r /opt/jboss/jon-update \
 && rm /opt/jboss/rhq-agent-update.log \
 && rm -r /opt/jboss/tmp
#VOLUME ["/opt/jboss/jdg/jboss-datagrid-6.5.1-server/standalone","/opt/jboss/jon/rhq-agent/conf"]
USER jboss
CMD /usr/bin/startSshAndJdg.sh
EXPOSE 80 6666 8009 8080 8181 8787 8443 9443 3528 3529 7500 45700/udp 9876/udp 23364/udp 7600 57600 55200/udp 45688/udp 54200/udp 5445 8090 4417 4447 4712 4713 9990 9999 7080 11211 11222 16163  22
