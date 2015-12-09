FROM docker-registry.usersys.redhat.com/docker4jboss/base

# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

ENV HADOOP_VERSION 2.7.1
ENV JAVA_HOME /usr/lib/jvm/java
ENV HADOOP_PREFIX /opt/hadoop
ENV HADOOP_COMMON_HOME /opt/hadoop
ENV HADOOP_HDFS_HOME /opt/hadoop
ENV HADOOP_MAPRED_HOME /opt/hadoop
ENV HADOOP_YARN_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop


RUN dnf -y install java-1.8.0-openjdk-devel \
 && dnf clean all \
 && curl -s http://www.us.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar -xz -C /opt \
 #&& rm -rf /opt/hadoop-${HADOOP_VERSION}/lib/native \
 #&& curl -Ls http://dl.bintray.com/sequenceiq/sequenceiq-bin/hadoop-native-64-${HADOOP_VERSION}.tar | tar -x -C /opt/hadoop-${HADOOP_VERSION}/lib \
 && cd /opt \
 && chown -R root:root /opt/hadoop-${HADOOP_VERSION}/* \
 && ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop

ADD ./support /tmp/host/support

RUN chmod -R 777 /tmp/host \
 && sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java\nexport HADOOP_PREFIX=/opt/hadoop\nexport HADOOP_HOME=/opt/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh \
 && sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh \
 && mkdir $HADOOP_PREFIX/input \
 && mkdir /root/hdfs \
 && cp $HADOOP_PREFIX/etc/hadoop/*.xml $HADOOP_PREFIX/input \
 && cp -rf /tmp/host/support/hadoop-conf/*.xml $HADOOP_PREFIX/etc/hadoop \
 && chmod +x /opt/hadoop/etc/hadoop/*-env.sh \
 && mkdir -p /opt/hadoop/hadoopdata/hdfs/datanode \
 && mkdir -p /opt/hadoop/hadoopdata/hdfs/namenode \
 && mkdir -p /opt/hadoop/hadoopdata/tmp \
 && $HADOOP_PREFIX/bin/hdfs namenode -format

RUN /usr/sbin/sshd && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/root
RUN /usr/sbin/sshd && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfs -put $HADOOP_PREFIX/etc/hadoop/ input

RUN cp /tmp/host/support/startHadoopContainer.sh /usr/bin \
 && echo 'source /opt/hadoop/etc/hadoop/hadoop-env.sh' > /root/.bashrc \
 && rm -rf /tmp/host

CMD /usr/bin/startHadoopContainer.sh

EXPOSE 50010 50020 50030 50060 50070 50075 50090 50105 19888 8030 8031 8032 8033 8040 8042 8088 8080 49707 22 2122 9000 9001
