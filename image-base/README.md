Base Image
=======

A base image on fedora 22 base that contains useful tools including sshd server. Images in this project are not intended to use in production, our aim is putting all of the useful tools inside images to gain more flexibility for demos, workshops, tests, etc


### How to use
This image designed as a base layer for others, but it might be useful in some cases as well.

Default command starts sshd server :

```bash
  docker run -it --name base --hostname my_container docker4jboss/base
```
root password is changed as ```redhat1!```.  Although I recommend to use [docker-enter](https://github.com/Pithikos/docker-enter) or [nsenter](https://github.com/jpetazzo/nsenter) to access into a container, for some environments like windows toolset is not available.

To ssh into container:
```bash
   ssh root@my_container  
```

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/base```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/base .
```
  or simply run

```bash
  sh build.sh
```

 > You can clean your environment with ```docker-clean``` script
