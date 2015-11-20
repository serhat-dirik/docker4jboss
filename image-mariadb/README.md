Maria DB Image
=======

A maria database image derived from [base image](../image-base/README.md) including ssh server.


## Building The Image
 If you're planning to use your image for the composed demo environments within this project,you must use the recommended naming ```docker4jboss/mysql```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/mariadb .
```
or simply run

```bash
sh build.sh
```

> You can clean your environment with ```docker-clean``` script

## How to use this image

  Just run it in interactive mode or daemon mode

 ```bash
  docker run -it --name mariadb --hostname mariadb docker4jboss/mariadb
 ```

  Standard 3306 port for mariadb and 22 for ssh are exposed. ```root``` user is defined with ```mariadb``` password. Port 22 also exposed, so you can ssh into containers
