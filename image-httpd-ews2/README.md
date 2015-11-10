EWS 2 - HTTPD Image
=======
  Extended from [base image](../image-base/README.md).

- Apache httpd server with mod_cluster. EAP 6 binaries (JBoss EWS 2.1)  are used for this setup. /opt/apache/jboss-ews-2.1
- JON agent is also installed and can be found under /opt/apache/jon
- JDK 1.8
- SSHD Server

 Ports 80 6666 8000 8009 25 22 are exposed


### How to use

Default command executes a HTTPD server  with mod_cluster. Since JON agent configuration requires some modification before start it, its not started by default. SSHD server is also started, so you can ssh into the running container.
To start it:
```bash
 docker run -it --name httpd --hostname httpd docker4jboss/httpd-ews2
```
Default configuration should be enough to discover EAP nodes on the same network and bind them to the balancer. Mod cluster manager is hosted can be reached http://${CONTAINER}:80/mod_cluster-manager

If you need RHQ agent in place, you need to explicitly start it or predefined script
```bash
docker run -it --name httpd --hostname httpd docker4jboss/httpd-ews /bin/bash -c "/opt/apache/launchWithJon.sh"
```
Before you run JON agent, please be sure that JON Server (3.3) is running & jon server binding address is properly defined in agent-configuration.xml  file

If you like to use this image as a loadbalancer for your EAP servers, don't forget to define port 6666 like "httpd:6666" in your proxy server list.


## Build Prerequisites

### Installation Files

You need to download & place required files into install subdirectory. Please read [README](./install/README.md) file under install subdirectory
to see list of required files and how to download.

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/httpd-ews2```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/httpd-ews2 .
```
  or simply run

```bash
  sh build.sh
```

 > You can clean your environment with ```docker-clean``` script
