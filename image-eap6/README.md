Base EAP 6 Image
=======

A base JBoss EAP 6 (currently 6.4.5) image that extends [base image](../image-base/README.md) to create & execute EAP 6 demo containers on top. JON Agent & sshd server are also installed inside this image, therefore JON Server can be configured to monitor & manage and it can be also used as a remote host with ssh support.

### Image Content

- Fedora:latest + additional packages to run EAP
- JDK 1.8 , Maven & Git
- EAP 6.4.5 , User :  ```admin``` ```redhat1!``` , all of the [Default Ports](https://access.redhat.com/documentation/en-US/JBoss_Enterprise_Application_Platform/6.1/html/Security_Guide/Network_Ports_Used_By_JBoss_Enterprise_Application_Platform_62.html)  of EAP server are exposed
- JON 3.3.3 Agent & 16163 port is also exposed
- Open SSHD Server

### How to use

Default command executes a standalone EAP server (without starting the jon agent). If this is the only stuff that you need, just run it :

```bash
  docker run -it --name eap --hostname eap docker4jboss/eap6base
```

 If you need RHQ agent in place, you need to explicitly start it or just use wrapper command that prepared for you:
```bash
docker run -it --name eap --hostname eap docker4jboss/eap6 /bin/bash -c "/usr/bin/startSshJonAndEap.sh"
```
 > In standalone mode, EAP is started in debug mode and debug port is specified as 8787.

To boot it in domain mode:

```bash
docker run -it --name eap --hostname eap docker4jboss/eap6 /bin/bash -c "/usr/bin/startSshJonAndEapInDmnMode.sh"
```
  or

```bash
docker run -it --name eap --hostname eap docker4jboss/eap6 /bin/bash -c "/usr/bin/startSshAndEapInDmnMode.sh"  
```
Before you run JON agent, please be sure that JON Server (3.3) is running & jon server binding address is properly defined in agent-configuration.xml  file. ```admin``` user is pre-defined and can be used for EAP server management. It's password is assigned as ```redhat1!```


## Build Prerequisites

### Installation Files
   You need to download & place required files into install subdirectory. Please read [README](./install/README.md) file under install subdirectory
   to see required files.

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended name ```docker-registry.usersys.redhat.com/docker4jboss/eap6```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker-registry.usersys.redhat.com/docker4jboss/eap6 .
```
  or simply run

```bash
  sh build.sh
```

 > You can clean your environment with ```docker-clean``` script
