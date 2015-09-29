Hadoop Image
=======
 Hadoop 2.7.1


### How to use

Default command starts sshd server and hadoop daemons:

```bash
  docker run -it --name hadoop --hostname hadoop docker4jboss/hadoop
```
Image is configured as a single hadoop node which is useful for demos & debugging, but it can be easily reconfigured to run as clustered node, just place new configuration in /opt/hadoop/etc/hadoop and execute the default command  /usr/bin/startHadoopContainer.sh.

root password is changed as ```redhat1!```.  Although I recommend to use [docker-enter](https://github.com/Pithikos/docker-enter) or [nsenter](https://github.com/jpetazzo/nsenter) to access into a container, for some environments like windows toolset is not available.

To ssh into container:
```bash
   ssh root@my_container  
```

## Building The Image

 If you're planning to use your image for the composed demo environments within this project, you must use the recommended naming ```docker4jboss/hadoop```. Otherwise, specify the tag name as you wish.

```bash
docker build --force-rm=true -t docker4jboss/hadoop .
```
  or simply run

```bash
  sh build.sh
```

> You can clean your environment with ```docker-clean``` script

##Test

Browse the web interface for the NameNode and the Applications; by default they are available at:

- NameNode - http://$container_ip:50070/
- All Applications - http://$container_ip:8088/

Ssh into the container and run examples:
```
$ cd  /opt/hadoop
$ bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'
```


Examine the output files:

```
bin/hdfs dfs -cat output/*
```
