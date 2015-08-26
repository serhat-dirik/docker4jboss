Base EAP 6 Image
=======

A base JBoss EAP 6 image that extends fedora:22 to create & execute EAP 6 demo containers on top. JON Agent is also installed inside this image, therefore JON Server can be configured to monitor & manage any container on top of this image.

### Image Content

- Fedora:latest + additional packages to run EAP
- JDK 1.8 , Maven & Git
- EAP 6.4.2 , User :  ```admin``` ```redhat1!``` , all of the [Default Ports](https://access.redhat.com/documentation/en-US/JBoss_Enterprise_Application_Platform/6.1/html/Security_Guide/Network_Ports_Used_By_JBoss_Enterprise_Application_Platform_62.html)  of EAP server are exposed
- JON 3.3.3 Agent & 16163 port is also exposed

### How to use

Default command executes a standalone EAP server (without starting the jon agent), if this is the only stuff that you need, just run it :

```bash
  docker run -it --name eap docker4jboss/eap6base
```
  To boot it in domain mode:
```bash
  docker run -it --name eap docker4jboss/eap6base /opt/jboss/eap/jboss-eap-6.4/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0
```
   If you need RHQ agent in place, you need to explicitly start it
```bash
docker run -it docker4jboss/eap6-base /bin/bash -c "/opt/jboss/jon/rhq-agent/bin/rhq-agent-wrapper.sh start; /opt/jboss/eap/jboss-eap-6.4/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0"
```
   Before you run JON agent, please be sure that JON Server (3.3) is running & jon server binding address is properly defined in agent-configuration.xml  file

```admin``` user is defined and can be used for EAP server management. It's password is ```redhat1!``` ;)


## Build Prerequisites

### Installation Files

The file list below need to be downloaded from [Red Hat Customer site](http://access.redhat.com) and placed into the install subdirectory.

* EAP 6.4 Files
  * jboss-eap-6.4.0.zip
  * jboss-eap-6.4.1-patch.zip
  * jboss-eap-6.4.2-patch.zip
  * jboss-eap-native-utils-6.4.0-RHEL7-x86_64.zip
  * jboss-eap-native-webserver-connectors-6.4.0-RHEL7-x86_64.zip
  * jboss-eap-native-6.4.0-RHEL7-x86_64.zip
  * jboss-ews-httpd-2.1.0-RHEL7-x86_64.zip
* JON 3.3 Files
  * jon-server-3.3-update-03.zip
  * rhq-enterprise-agent-4.12.0.JON330GA.jar (you need to extract this file from JON Server installation zip file)

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/eap6-base```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/eap6-base .
```
  or simply run

```bash
  sh build.sh
```

 > You can clean your environment with ```docker-clean``` script
