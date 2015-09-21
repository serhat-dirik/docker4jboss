# Use postgres image as a base
FROM docker4jboss/eap6
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

USER root
#Add local sources
ADD . /tmp/host
RUN chmod -R 777 /tmp/host
############################################
# Install JBoss Data Virtualization 6.1.0.GA
############################################
USER jboss

RUN java -jar /tmp/host/install/jboss-dv-installer-6.2.0.redhat-2.jar /tmp/host/support/auto.xml \
# && /opt/jboss/dv/jboss-eap-6.4/bin/jboss-cli.sh --command="patch apply /tmp/host/install/BZ-1185069.zip --override-all" \
 && cp /tmp/host/install/*.war /opt/jboss/eap/jboss-eap-6.4/standalone/deployments \
 && rm -rf /opt/jboss/dv/jboss-eap-6.4/standalone/configuration/standalone_xml_history/current

USER root
#Clean Up
RUN rm -r /tmp/host/*

USER jboss
CMD /usr/bin/startSshAndEap.sh
EXPOSE 80 5432 3306 27017 31000 35432 6666 8009 8080 8787 8443 3528 3529 7500 45700/udp 9876/udp 23364/udp 7600 57600 55200/udp 45688/udp 54200/udp 5445 8090 4417 4712 4713 9990 9999 7080 16163 25 22
