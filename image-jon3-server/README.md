JON 3 Server
=======

A comprehensive, all in one JON 3.3 Server image extended from [postgres image](../image-postgres-9/README.md). Database, Storage, Server & Local agent components are all installed locally. This image contains all agent plugin packs, so almost all JBoss Middleware can be monitored and managed.  

### Image Content

- Fedora:22
- Postgres 9.3, default port 5432 is exposed, administrative user ```postgres``` is defined (password ```postgres```). ```rhqadmin``` user is defined for JON related tasks (password is ```rhqadmin```).  
- JDK 1.8
- JON 3.3 Storage, Server & Local agent
- SSH Server

## Prerequisites

### Installation Files

The file list below need to be downloaded from [Red Hat Customer site](http://access.redhat.com) and placed into the this directory

* JON 3.3 Files
  * jon-server-3.3-update-03.zip
  * jon-plugin-pack-eap-3.3.0.GA.zip
  * jon-server-3.3.0.GA.zip
  * jon-plugin-pack-ews-3.3.0.GA.zip  
  * jon-plugin-pack-brms-bpms-3.3.0.GA.zip
  * jon-plugin-pack-datavirtualization-3.3.0.GA.zip
  * jon-plugin-pack-fuse-3.3.0.GA.zip  

## Building The Image
 If you're planning to use your image for the composed demo environments within this project,you must use the recommended naming is ```docker4jboss/jon3-server```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/jon3-server .
```

or simply run

```bash
sh build.sh
```

> You can clean your environment with ```docker-clean``` script

## How to use this image

First initialization of this image may require sometime to finish initial installation steps.

 ```bash
  docker run -it --name jon3-server docker4jboss/jon3-server
 ```

 After your installation is completed, visit JON administration page ```http:\\${ContainerIP}:7080```. You can use ```rhqadmin``` as both user name and password.  
