FROM centos:7.2.1511
MAINTAINER Losywee@gmail.com
LABEL env=des

#Install ssh
RUN yum -y install sudo epel-release openssh-server shadow-utils openssh-clients tar
#Make run.sh
RUN echo -e "ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && echo \"root:password\" | chpasswd && && /usr/sbin/sshd -D" > /run.sh

#Clean
RUN yum rm -rf /var/cache/yum/* \
    && yum clean all
EXPOSE 22
CMD ["/bin/bash","/run.sh"]

