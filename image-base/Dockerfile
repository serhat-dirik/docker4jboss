# Use fedora 22 image as the base
FROM fedora:22

# Maintainer details
MAINTAINER Serhat Dirik<serhat@redhat.com>

##############################################
# Set root password
##############################################
RUN echo "root:redhat1!" | /usr/sbin/chpasswd \
# Execute system update
 && dnf -y update \
# Install some necessary packages \
 && dnf -y install hostname git xmlstarlet saxon augeas bsdtar which unzip sudo openssl openssh-clients openssh-server iputils iproute httpd-tools wget tar git findutils vim-enhanced curl telnet initscripts \
# clean cache \
 && dnf clean all \
 # Increase ulimit
 && echo "* soft nofile 4096" >> /etc/security/limits.conf \
 && echo "* hard nofile 4096" >> /etc/security/limits.conf \
 #  allow testing with buffers up to 64MB
 && echo "net.core.rmem_max = 67108864" >> /etc/sysctl.conf \
 && echo "net.core.wmem_max = 67108864" >> /etc/sysctl.conf \
 #enable ssh access
 && rm -f /etc/ssh/ssh_*_key  \
 && ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key \
 && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key  \
 && ssh-keygen -q -N "" -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
 && ssh-keygen -A \
 && sed -i "s/#*UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
 && sed -i "s/#*UseDNS.*/UseDNS no/g" /etc/ssh/sshd_config \
 && echo "sshd: ALL" > /etc/hosts.allow

ADD . /tmp/host
RUN cp /tmp/host/support/startSshAndLoop.sh /usr/bin \
 && chmod +x /usr/bin/startSshAndLoop.sh
CMD /usr/bin/startSshAndLoop.sh
EXPOSE 25 22
