Postgres 9.3 Image
=======

A Postgres 9.3 database image that can be used for any purpose. This image is also
used as a base image for JON3-Server image.


## Building The Image
 If you're planning to use your image for the composed demo environments within this project,you must use the recommended naming ```docker4jboss/postgres-9.3```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/postgres-9.3 .
```
or simply run

```bash
sh build.sh
```

> You can clean your environment with ```docker-clean``` script

## How to use this image

  Just run it in interacctive mode or daemon mode

 ```bash
  docker run -it --name postgres docker4jboss/postgres-9.3
 ```

  Standard 5432 port is exposed. ```postgres``` user is defined with ```postgres``` password.
