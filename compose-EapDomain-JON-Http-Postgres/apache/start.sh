#!/bin/bash
su - apache -c "/opt/apache/jon/rhq-agent/bin/rhq-agent-wrapper.sh start"
/opt/apache/jboss-ews-2.1/httpd/sbin/apachectl start
#/opt/apache/jws-3.0/httpd/sbin/apachectl start
