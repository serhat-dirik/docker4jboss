JBoss Data Virtualization 6 Image
=======

JBoss Data Virtualization 6 (currently 6.1.2) image that extends [base image](../image-base/README.md).JON Agent & sshd server are also installed inside this image, therefore JON Server can be configured to monitor & manage and it can be also used as a remote host with ssh support.

### Image Content

- Fedora:latest + additional packages to run EAP
- JDK 1.8  
- DV 6.1.2 , User :  ```admin``` ```redhat1!``` , all of the [Default Ports](https://access.redhat.com/documentation/en-US/JBoss_Enterprise_Application_Platform/6.1/html/Security_Guide/Network_Ports_Used_By_JBoss_Enterprise_Application_Platform_62.html)  of EAP server are exposed. Default teiid jdbc port 31000 is also exported
- JON 3.3.3 Agent & 16163 port is also exposed
- Open SSHD Server

### How to use

Default command executes a standalone EAP server (without starting the jon agent). If this is the only stuff that you need, just run it :

```bash
  docker run -it --name dv6 --hostname dv6 docker4jboss/dv6
```

 > In standalone mode, EAP is started in debug mode and debug port is specified as 8787.

Before you run JON agent, please be sure that JON Server (3.3) is running & jon server binding address is properly defined in agent-configuration.xml  file. ```admin``` user is pre-defined and can be used for EAP server management. It's password is assigned as ```redhat1!```

   Important Links and Users:
- EAP Admin ```admin``` - ```redhat1!``` http://dv6:9990/console
- Teiid Server ```teiidUser``` - ```redhat1!``` http://dv6:8080/odata/VDB JDBC URL: jdbc:teiid:VDB@mm://dv6:31000
- ModShape ```modeshapeUser``` - ```redhat1!``` http://dv6:8080/modeshape-rest
- DashBoard ```dashboardAdmin``` - ```redhat1!``` http://dv6:8080/dashboard
- Web UI ```admin``` - ```admin``` http://dv6:8080/dv-ui

## Build Prerequisites

### Installation Files

The file list below need to be downloaded from [Red Hat Customer site](http://access.redhat.com) and placed into the install subdirectory.

* DV Files
  *	jboss-dv-installer-6.1.0.redhat-3.jar
  * BZ-1185069.zip (dv fix 1)
  * BZ-1213582.zip (dv fix 2)
  * Web UI Preview [PREVIEW-DataVirtWebUI-11JUn2015.war](http://www.jboss.org/products/datavirt/download/)
* JON 3.3 Files
  * jon-server-3.3-update-03.zip
  * rhq-enterprise-agent-4.12.0.JON330GA.jar (you need to extract this file from JON Server installation zip file)

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/dv6```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/dv6 .
```
  or simply run

```bash
  sh build.sh
```

 > You can clean your environment with ```docker-clean``` script
