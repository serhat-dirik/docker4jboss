#Docker for JBoss

This project contains docker images & composed environments for JBoss Middleware that designed for demos, tests, workshops & trials. Please beware of that container images in this project are not designed for in production use purposes, indeed images are fat and loaded with tools to make your tests & demos are more easy.

I tried to use a clean naming convention for sub directories in the project, so it should be clear what resides under each subdirectory. You can also find a fair documentation  and instructions under each subdirectory. I suggest start digging with compose subdirectories that created for composition of several components working together for a certain purpose, than build required images & start playing.

- [image-base](./image-base/README.md) : A Base image that extended from fedora:22 and loaded with several useful tools including ssh server
- [image-eap6](./image-eap6/README.md) : JBoss EAP 6.4.3 and JON Agent
- [image-httpd-ews2](./image-httpd-ews2/README.md): Apache HTTPD (JBoss EWS2) server & JON Agent
- [image-jon3-server](./image-jon3-server/README.md): JON 3.3 All in one server, eap, ews, dv, bpm, brms, fuse, amq agents are included
- [image-postgres-9](./image-postgres-9/README.md): Postgres 9.3 Server
- [image-dv6](./image-dv6/README.md): JBoss Data Virtualizations 6.2 + Web UI
- [image-hadoop](./image-hadoop/README.md) Hadoop 2.7.1
- [image-hive](./image-hive/README.md) Hive 1.2.1
- [compose-EapDomain-JON-Httpd-Postgres](./compose-EapDomain-JON-Httpd-Postgres/README.md): 3 EAP server in domain mode as one master and two slaves, httpd as front load balancer and JON server for management & monitoring. A simple cluster test application is also included.
- [compose-DataVirtualizationByExample](./compose-DataVirtualizationByExample/README.md): JDV 6.2 in domain mode (clustered), Httpd as load balancer, JON for management and monitoring, Postgres, Mysql and Hive as data sources are installed in this environment and [DataVirtualizationByExample](https://github.com/DataVirtualizationByExample) demo projects are also deployed.

> All image binaries can be found in Red Hat's [internal registry](http:/docker-registry.usersys.redhat.com). If you're an RedHatter, you can download images from that repository instead of building locally.

## Prerequisites

### Docker

Docker must be installed and configured. See the following documentation to download and configure docker on your platform

* [Red Hat Enterprise Linux](https://docs.docker.com/installation/rhel/)
* [Mac OS X](https://docs.docker.com/installation/mac/)
* [Microsoft Windows](https://docs.docker.com/installation/windows/)

A comprehensive platform list can be found [here](https://docs.docker.com/installation/)

To get started with Docker, please refer to the official [user guide](https://docs.docker.com/userguide/)

### Docker Compose
[docker-compose](https://docs.docker.com/compose/) can help you to run composed environments in more easy and efficient way. Please install the latest version as following the instructions on [docker-compose web page](https://docs.docker.com/compose/install/).

### Disable Firewalld (RHEL, CentOS, Fedora) on Your Host
Firewalld is default firewall management in RHEL 7, Centos 7, and Fedora 18+. It's a new stack replacing iptables but docker controls iptables and don't know how to deal with firewalld yet, so its strongly suggested that you stop firewalld service & start iptables service on Red Hat linux derivatives before you run any composed environments.  An alternative approach to this would be defining required rule sets for internal container communication and change docker's default option to ```--iptables=false`` to prevent docker changing iptables on your host. Let me warn you, about that this means that you'll be doing a lot of work manually by yourself.
  If iptables package not already installed on your system, install it.
```bash
yum install iptables-services
```
In order to disable firewalld and enable iptables , use commands:

```bash
systemctl disable firewalld.service
systemctl stop firewalld.service
systemctl enable iptables.service
systemctl enable ip6tables.service
systemctl start iptables.service
systemctl start ip6tables.service
systemctl stop docker
systemctl daemon-reload
systemctl start docker
```


### Docker Config

I prefer to give the most flexible network permissions to docker to prevent undesired pain. I recommend you to use change docker options in  your ```/etc/sysconfig/docker``` file as below.

```
OPTIONS='--selinux-enabled --icc=true --iptables=true'
```
If you curious about this settings, I suggest you to read [docker networking page](https://docs.docker.com/articles/networking/#between-containers).
