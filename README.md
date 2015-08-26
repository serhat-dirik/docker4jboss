#Docker for JBoss

Docker images & composed environments for JBoss Middleware Components that useful for demos, tests, workshops & trials.

I tried to use a clean naming convention for directory names, so it should be quite understandable what resides under each subdirectory. I suggest start digging with compose subdirectories that created for composition of several components working together for a certain purpose, build required images & start playing.

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

### Disable Firewalld (RHEL, CentOS, Fedora)
Firewalld is default firewall management in RHEL 7, Centos 7, and Fedora
18+. It's a new stack instead of iptables but docker controls iptables, don't know how to use firewalld, so its strongly suggested that you stop firewalld service & start iptables service on Red Hat linux derivatives before you run any composed environments.  An alternative approach to this would be defining required rule sets for internal container communication and change docker's default option to ```--iptables=false`` to prevent docker changing iptables on your host. Let me warn you, about this means that you'll be doing a lot of work manually by yourself.

In order to change firewalld & iptables setting, use the below commands

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
 And before you do that please make sure that iptables package is loaded to your system. If it's not, just install it as below:

 ```bash
 yum install iptables-services
 ```

### Docker Config

I prefer to give the most flexible network permissions to docker to prevent undesired pain. I recommend you to use change docker options in  your ```/etc/sysconfig/docker``` file as below.

```
OPTIONS='--selinux-enabled --icc=true --iptables=true'
```
If you curious about this settings, I suggest you to read [docker networking page](https://docs.docker.com/articles/networking/#between-containers).
