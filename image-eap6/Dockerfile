# Use fedora 22 image as the base
FROM docker4jboss/base

# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

# Maven version
ENV MAVEN_VERSION 3.2.5
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
ENV JBOSS_HOME /opt/jboss/eap/jboss-eap-6.4
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


##############################################
# Install EAP
##############################################
RUN mkdir $HOME/eap \
 && mkdir $HOME/tmp \
 && /usr/bin/unzip -q /tmp/host/install/jboss-eap-6.4.0.zip -d $HOME/eap \
 && /usr/bin/unzip -q -o /tmp/host/install/jboss-eap-native-6.4.0-RHEL7-x86_64.zip -d $HOME/eap \
 && /usr/bin/unzip -q -o /tmp/host/install/jboss-eap-native-utils-6.4.0-RHEL7-x86_64.zip -d $HOME/eap \
 && /usr/bin/unzip -q -o /tmp/host/install/jboss-eap-native-webserver-connectors-6.4.0-RHEL7-x86_64.zip -d $HOME/eap \
#Update
 && $HOME/eap/jboss-eap-6.4/bin/jboss-cli.sh --command="patch apply /tmp/host/install/jboss-eap-6.4.1-patch.zip --override-all" \
 && $HOME/eap/jboss-eap-6.4/bin/jboss-cli.sh --command="patch apply /tmp/host/install/jboss-eap-6.4.2-patch.zip --override-all" \
 && $HOME/eap/jboss-eap-6.4/bin/jboss-cli.sh --command="patch apply /tmp/host/install/jboss-eap-6.4.3-patch.zip --override-all" \
 && $HOME/eap/jboss-eap-6.4/bin/jboss-cli.sh --command="patch apply /tmp/host/install/BZ-1258994.zip --override-all" \
# Modify permissions on Maven settings file
 && cp /tmp/host/support/settings.xml /opt/jboss/.m2/settings.xml \
 && chown jboss:jboss /opt/jboss/.m2/settings.xml \
#Add admin User
 && /opt/jboss/eap/jboss-eap-6.4/bin/add-user.sh admin redhat1! --silent

# Switch back to root to clean environment
USER root
#Clean Up
RUN cp /tmp/host/support/*.sh /usr/bin \
 && rm -r /tmp/host/* \
 && rm -r /opt/jboss/jon-update \
 && rm /opt/jboss/rhq-agent-update.log \
 && rm -r /opt/jboss/tmp
#VOLUME ["/opt/jboss/eap/jboss-eap-6.4/standalone","/opt/jboss/eap/jboss-eap-6.4/domain","/opt/jboss/jon/rhq-agent/conf"]
USER jboss
CMD /usr/bin/startSshAndEap.sh
EXPOSE 80 6666 8009 8080 8787 8443 3528 3529 7500 45700/udp 9876/udp 23364/udp 7600 57600 55200/udp 45688/udp 54200/udp 5445 8090 4417 4712 4713 9990 9999 7080 16163 25 22
