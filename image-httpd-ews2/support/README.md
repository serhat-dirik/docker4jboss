# Support Files

 Additional configuration files & scripts

* agent-configuration.xml : JON Agent file default confguration. Please change rhq.agent.server.bind-address property within this file before you run the agent. This file is placed at ```/opt/jbossjon/rhq-agent/conf``` directory in the image
* httpd.conf: Apache main configuration file
* mod_cluster.conf: Mod Cluster configuration settings
* launch.sh: A schell script to start apache
* launchWithJon.sh: Similar to launch.sh, but starts JON agent as well 
