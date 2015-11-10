FROM docker4jboss/base
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

RUN rpm -iUvh http://dev.mysql.com/get/mysql-community-release-fc22-5.noarch.rpm \
 && dnf install -y mysql-community-server

RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf \
 && if [ ! -f /usr/share/mysql/my-default.cnf ] ; then cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf; fi && \
 && mysql_install_db > /dev/null 2>&1 \
 && touch /var/lib/mysql/.EMPTY_DB


 ENV MYSQL_USER=admin \
     MYSQL_PASS=redhat1! \
     ON_CREATE_DB=**False** \
     REPLICATION_MASTER=**False** \
     REPLICATION_SLAVE=**False** \
     REPLICATION_USER=replica \
     REPLICATION_PASS=replica
 RUN su - mysql -c "mysqld  --user=root" \
      && mysqladmin -u root password "redhat1!" \
      && dnf clean all

#RUN su - mysql -c "mysqld --initialize --user=root >>/dev/null"


ADD ./support/startDBandLoop.sh /usr/bin

RUN chmod +x /usr/bin/startDBandLoop.sh

CMD startDBandLoop.sh

VOLUME /var/lib/mysql

EXPOSE 3306 22
