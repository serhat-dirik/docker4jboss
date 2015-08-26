EAP 6 - HTTPD Image
=======

- Apache httpd server with mod_cluster. EAP 6 binaries (JBoss EWS 2.1)  are used for this setup. /opt/apache/jboss-ews-2.1
- JON agent is also installed /opt/apache/jon
- JDK 1.8

 Port 80 and 6666 are exposed


### How to use

Default command executes a HTTPD server  with mod_cluster. Since JON agent configuration requires some modification before start it, its not started by default.

```bash
 docker run -it --name httpd docker4jboss/httpd-eap6
```
 Default configuration should be enough to discover EAP nodes on the network and bind them to the balancer. Mod cluster manager is hosted can be reached http://${CONTAINER}:80/mod_cluster-manager

  If you need RHQ agent in place, you need to explicitly start it
```bash
docker run -it docker4jboss/eap6-base /bin/bash -c "/opt/apache/jon/rhq-agent/bin/rhq-agent-wrapper.sh start;  /opt/apache/launch.sh"
```
  Before you run JON agent, please be sure that JON Server (3.3) is running & jon server binding address is properly defined in agent-configuration.xml  file


## Build Prerequisites

### Installation Files

The file list below need to be downloaded from [Red Hat Customer site](http://access.redhat.com) and placed into the install subdirectory.

* EAP 6.4 Files
  * jboss-eap-native-webserver-connectors-6.4.0-RHEL7-x86_64.zip
  * jboss-ews-httpd-2.1.0-RHEL7-x86_64.zip
  * jws-httpd-3.0.0-RHEL7-x86_64.zip
* JON 3.3 Files
  * jon-server-3.3-update-03.zip
  * rhq-enterprise-agent-4.12.0.JON330GA.jar (you need to extract this file from JON Server installation zip file)

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/httpd-eap6```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/httpd-eap6 .
```
  or simply run

```bash
  sh build.sh
```

 > You can clean your environment with ```docker-clean``` script
