Base Image
=======

A base image based on fedora which contains useful tools for shell and sshd server. Images in this project (docker4jboss) are not intended to use in production, our aim is putting all of the useful tools inside images to gain more flexibility for demos, workshops and tests. Sshd server is just one example which required to connect JBoss Middleware Servers from JBDS IDE as remote server.

### How to use
This image designed as a base layer for others, but it might be useful in some cases as well.

Default command starts sshd server & loops forever until you enter exit:

```bash
  docker run -it --name base --hostname my_container docker4jboss/base
```
root password is changed as ```redhat1!```.  Although I recommend to use [docker-enter](https://github.com/Pithikos/docker-enter) or [nsenter](https://github.com/jpetazzo/nsenter) to access into a container, for some environments like windows tool set is not always available.

To ssh into container:
```bash
   ssh root@my_container  
```

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/base```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/base .
```
  I recommend to use ```build.sh``` script instead of ```docker build```, because of this script  contains compression and cleanup steps as well.

```bash
  sh build.sh
```
