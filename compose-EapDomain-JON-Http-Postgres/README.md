EAP Domain Mode, JON & Httpd Mod CLuster
=======

 This environment is designed to demonstrate EAP 6 Domain Operating mode with other complementary JBoss components. You can test EAP 6 İn domain mode with two slave nodes, JON management & monitoring capabilities. An apache httpd server is also installed as an LoadBalancer, so you can also test mod_cluster capabilities as well.

## Prerequisites

Following images need to be in your local registry:

- docker4jboss/eap6-base
- docker4jboss/httpd-eap6
- docker4jboss/postgres-9.3
- docker4jboss/jon3-server

If you haven't done yet, please build this images first on your local server.

```phensley/docker-dns ``` image is used as dns server. Pull it from docker hub

```bash
docker pull phensley/docker-dns
```

   docker-compose is also need to be installed

## How to run

   If everything is properly installed, following command should be enough

```bash
  sh run.sh
```

 Visit EAP master server  console ```http://eap-master:9990/console```, admin user name is ```admin``` and password is ```redhat1!```

 HTTPD loadbalancer is controlling port 80 on httpdserver, just connect ```http://httpdserver```. You can deploy web apps on EAP cluster and test loadbalancer from this address. Mod cluster manager is also accessible ```http://httpdserver/mod_cluster-manager``` address. Visit and see how your slave nodes are controlled

JON server  initialization is taking some time, give it a couple of minute first and than visit ```http:///rhqserver:7080``` address to log into the console. ```rhqadmin``` can be used as user name and ```rhqadmin``` again as password. Check the discovery tool, all of your servers (except postgres one) should be discovered and waiting for you to import to your inventory.

Postgres server is also the part of the environment for you to test database related facilities, like datasources.

Enjoy! 
