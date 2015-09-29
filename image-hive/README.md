Hive Image
=======
 Hive 1.2.1 on top of Hadoop 2.7.1


### How to use

Default command starts sshd server, postgres, hadoop and hive daemons:

```bash
  docker run -it --name hive --hostname hive docker4jboss/hive
```
Image is configured as a single hadoop node, postgres for hive metadata and hive itself. Hadoop is placed under /opt/hadoop directory and similarly hive is placed under /opt/hive. The default command  /usr/bin/startHiveContainer.sh starts all off the required daemons for you.

root password is changed as ```redhat1!```.  Although I recommend to use [docker-enter](https://github.com/Pithikos/docker-enter) or [nsenter](https://github.com/jpetazzo/nsenter) to access into a container, for some environments like windows toolset is not available.

To ssh into container:
```bash
   ssh root@my_container  
```
Postgres server is installed for hive metadata, but it can be also used for other purposes as well. Superuser ```postgres``` can be used with ```postgres``` password.

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/hive```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/hive .
```
  or simply run

```bash
  sh build.sh
```

> You can clean your environment with ```docker-clean``` script

##Test
After launching the container, ssh into it and type the following to run a sample hive query
```
  hive -f /tmp/store_sales.sql
```

You should see, map-reduce processes are proceed and successfully finished. On the web-ui ```http://$(containerip):8088``` same results can be seen.
  
