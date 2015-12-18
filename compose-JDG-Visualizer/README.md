JDG-CLuster & Visualizer Demo
========================

What is it?
-----------

This is a graphical JBoss Data Grid visualizer based on the 2011 JBoss World Keynote presented
by Burr Sutter (https://vimeo.com/25258416).

This visualizer works with out of the box JDG configuration with JMX and Management
User configured (see below for instructions).

# 1 Running the Demo

### 2.1 Starting the Data Grid Instances
Open a command line and navigate to the demo directory. Execute ``` sh runDemo.sh``` script, this will start two JDG instance clustered, one EAP instance
with Visualizer application, a dns server for containers internal communication and JON server. This script will add container ip addresses and host
names into your /etc/hosts file as well.

### 2.2 View the Demo Application
The application will be running at the following URL: <http://eap-server:8080/jdg-visualizer/>.

### 2.3 Load Data into the Grid
Use the hotrod-demo application to load data into the grid: <https://github.com/saturnism/hotrod-demo/>.

### 2.4 Add/Remove extra nodes to the JDG grid
Open a command line and navigate to the demo directory. Execute ```sh addNode.sh jboss-node3``` to add a new node named as ```jboss-node3```. Watch it in Visualizer screen, a couple of seconds it will popup as a new node and filled with data. Use ```sh removeNode.sh jboss-node3``` script to remove that node from cluster.

#### 2.5 Destroy Demo
Remove extra nodes one by one as using ```removeNode.sh``` command and than execute ```destroyDemo.sh``` command to stop and remove all of the demo containers
