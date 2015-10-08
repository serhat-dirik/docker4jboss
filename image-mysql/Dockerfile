FROM docker4jboss/base
# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

RUN rpm -iUvh http://dev.mysql.com/get/mysql-community-release-fc22-5.noarch.rpm \
 && dnf install -y mysql-community-server


RUN su - mysql -c "mysqld --initialize --user=root >>/dev/null"
RUN su - mysql -c "mysqld  --user=root" \
 && mysqladmin -u root password "redhat1!" \
 && dnf clean all

ADD ./support/startDBandLoop.sh /usr/bin

RUN chmod +x /usr/bin/startDBandLoop.sh

CMD startDBandLoop.sh

VOLUME /var/lib/mysql

EXPOSE 3306 22
