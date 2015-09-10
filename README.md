#Docker for JBoss

This project contains docker images & composed environments for JBoss Middleware that designed for demos, tests, workshops & trials. Please beware of that container images in this project are not designed for in production use purposes, indeed images are fat and loaded with tools to make your tests & demos are more easy.

I tried to use a clean naming convention for sub directories in the project, so it should be clear what resides under each subdirectory. You can also find a fair documentation  and instructions under each subdirectory. I suggest start digging with compose subdirectories that created for composition of several components working together for a certain purpose, than build required images & start playing.

## Prerequisites

### Docker

Docker must be installed and configured. See the following documentation to download and configure docker on your platform

* [Red Hat Enterprise Linux](https://docs.docker.com/installation/rhel/)
* [Mac OS X](https://docs.docker.com/installation/mac/)
* [Microsoft Windows](https://docs.docker.com/installation/windows/)

A comprehensive platform list can be found [here](https://docs.docker.com/installation/)

To get started with Docker, please refer to the official [user guide](https://docs.docker.com/userguide/)

### Docker Compose
You'll need [docker-compose](https://docs.docker.com/compose/) to run composed environments under subdirectories that start with "compose". Please install the latest version as following the instructions on [docker-compose web page](https://docs.docker.com/compose/install/).

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
