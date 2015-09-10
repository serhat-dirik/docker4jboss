Postgres 9 Image
=======

A Postgres 9.3 database image derived from [base image](../image-base/README.md) including ssh server and JON agent.


## Building The Image
 If you're planning to use your image for the composed demo environments within this project,you must use the recommended naming ```docker4jboss/postgres-9.3```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/postgres-9 .
```
or simply run

```bash
sh build.sh
```

> You can clean your environment with ```docker-clean``` script

## How to use this image

  Just run it in interactive mode or daemon mode

 ```bash
  docker run -it --name postgres --hostname postgres docker4jboss/postgres-9
 ```

  Standard 5432 port for postgres and 22 for ssh are exposed. ```postgres``` user is defined with ```postgres``` password. Port 22 also exposed, so you can ssh into containers
