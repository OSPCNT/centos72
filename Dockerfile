FROM centos:7.2.1511
MAINTAINER Losywee@gmail.com
LABEL env=des

RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
        && rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
  	&& rpm --import https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY		  	&& rpm --import https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY 

#Install ssh
# epel-release openssh-clients
RUN rpm --rebuilddb &&  yum -y install epel-release pwgen openssh-server shadow-utils tar
#Make run.sh
RUN echo -e "echo \"password\" || ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key  && echo \"password\" || ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && echo \"password\" || ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && echo \"root:password\" | chpasswd && /usr/sbin/sshd -D" > /run.sh

RUN chmod +x /*.sh

#Clean
RUN rm -rf /var/cache/yum/* \
    && yum clean all

EXPOSE 22
CMD ["/bin/bash","/run.sh"]

