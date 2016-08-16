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
RUN echo -e "echo \"password\" | ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key  && echo \"password\" | ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && echo \"password\" | ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && echo \"root:password\" | chpasswd && /usr/sbin/sshd -D" > /run.sh

RUN chmod +x /*.sh

#Clean
RUN rm -rf /var/cache/yum/* \
    && yum clean all
#Expose port range
EXPOSE 22 80 81 443 6666 7777 8888 9999 1080 8080 3000 9080 9443 1111 \
       1433 54 53 107 3283 4664 5500 1688 3074 445 444 5900 1701 1723 1194 655 \
       5000 5555 12975 32976 1812 1813 8887 25 24 50 465 587 5108 5109 110 109 \
       995 994 992 944 953 989 990 1025 1030 625 2121 4444 4445
 
CMD ["/bin/bash","/run.sh"]

