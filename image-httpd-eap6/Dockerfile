# Use fedora 22 image as the base
FROM fedora:22

# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

##############################################
# Set root password
##############################################
RUN  echo "root:redhat1!" | /usr/sbin/chpasswd \
# Execute system update
 && dnf -y update \
# && echo Install some necessary packages \
 && dnf -y install  which unzip sudo mailcap openssl openssh-clients iputils iproute httpd-tools wget tar git findutils  elinks apr apr-devel apr-util apr-util-devel apr-util-ldap \
# Install jdk 8
 && dnf -y install java-1.8.0-openjdk-devel \
# && echo clean cache \
 && dnf clean all

ENV JAVA_HOME /usr/lib/jvm/java

ADD . /tmp/host
RUN chmod -R 777 /tmp/host

# Create a user and group used to launch processes

RUN   getent group apache >/dev/null || groupadd -g 48 -r apache \
      && getent passwd apache >/dev/null || useradd -r -u 48   -g apache -m -d /opt/apache -c "Apache"  apache

# Set the working directory to user home directory
WORKDIR /opt/apache
# Specify the user which should be used to execute all commands below
USER apache
# Java home
ENV JAVA_HOME /usr/lib/jvm/java
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
# Install HTTPD
##############################################
ENV EWS_HOME /opt/apache/jboss-ews-2.1
ENV HTTPD_HOME /opt/apache/jboss-ews-2.1/httpd
RUN mkdir $HOME/eap \
 && /usr/bin/unzip -q -o /tmp/host/install/jboss-eap-native-webserver-connectors-6.4.0-RHEL7-x86_64.zip -d $HOME/eap \
 && /usr/bin/unzip -q /tmp/host/install/jboss-ews-httpd-2.1.0-RHEL7-x86_64.zip -d /opt/apache \
 && rm $EWS_HOME/httpd/modules/mod_auth_kerb.so \
 && mv $EWS_HOME/httpd/conf.d/auth_kerb.conf $EWS_HOME/httpd/conf.d/auth_kerb.sample \
 && mv $EWS_HOME/httpd/conf.d/ssl.conf $EWS_HOME/httpd/conf.d/ssl.sample
USER root

RUN cd /opt/apache/jboss-ews-2.1/httpd; /opt/apache/jboss-ews-2.1/httpd/.postinstall \
 && cp /tmp/host/support/mod_cluster.conf $HTTPD_HOME/conf.d  \
 && cp /tmp/host/support/launch.sh /opt/apache \
 && cp /opt/apache/eap/jboss-eap-6.4/modules/system/layers/base/native/lib64/httpd/modules/*.so $HTTPD_HOME/modules \
 && sed -i "s/LoadModule proxy_balancer_module modules\/mod_proxy_balancer.so/#\0/" $HTTPD_HOME/conf/httpd.conf \
 && rm -r /opt/apache/eap \
#Clean Up
 && mkdir -p /opt/apache/jboss-ews-2.1/httpd/www \
 && chmod -R 755  /opt/apache/jboss-ews-2.1/httpd/www \
 && chown -R apache:apache /opt/apache \
 && usermod -d  /opt/apache/jboss-ews-2.1/httpd/www apache \
 && rm -r /tmp/host/* \
 && rm -r /opt/apache/jon-update \
 && rm /opt/apache/rhq-agent-update.log

CMD /opt/apache/launch.sh
EXPOSE 80 6666 25 22
