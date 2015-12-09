FROM docker-registry.usersys.redhat.com/docker4jboss/base
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

RUN dnf install -y mariadb mariadb-server expect

ADD ./support/mysql_secure.sh /tmp

RUN  chmod +x /tmp/mysql_secure.sh \
 && /tmp/mysql_secure.sh \
 && rm /tmp/mysql_secure.sh \
 && dnf clean all

ADD ./support/startDBandLoop.sh /usr/bin

RUN chmod +x /usr/bin/startDBandLoop.sh

CMD startDBandLoop.sh

VOLUME ["/etc/my.cnf.d", "/var/lib/mysql"]

EXPOSE 3306 22
