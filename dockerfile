FROM centos:7
RUN useradd toto
RUN echo 'toto:toto' | chpasswd
RUN echo 'toto    ALL=(ALL)       ALL' >> /etc/sudoers
RUN usermod -aG wheel toto
#RUN mkdir /home/toto && chown toto /home/toto
RUN yum update -y 
RUN yum install openssh-server -y 
RUN yum install vim -y 
RUN yum install python -y 
RUN yum install sudo -y 
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN mkdir -p /root/.ssh
# RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7VwJ/cqwOVP1fjUWLr+XdzwojXBqqf8z3L5DgBG6FXymiXbVpgDhDxKCxA/8ZBEe3u/XfJ2e9WZvMSCCpbYojfyeXfatJ0CRHKbwnlzxNzbEP51ij/K0xCsIXCkJw4fm73MHqf/idz0YCU7XmN+HgmcSEZDmu8uyIVARf7H5gApAFPVrnnp6Xr4o05OvEkA/bYvjcahr9WmStAWGkN2PTlMtkDXzjKCwXYm9La/NRG9MXkgVER13PNqh+FOeNiqAvzz7vP3ogqOBxyfuC/BzB1NVRf/8tVlM6QYnmkkNadhTmqCUDaRCtc6gNDWxyWHtKyDGQoM3RAAhRYqpE/+Kl odelin@NEXLT079" >> /root/.ssh/authorized_keys
#RUN service ssh start
VOLUME [ "/sys/fs/cgroup" ]
RUN rm --force /run/nologin
#RUN systemctl start sshd
CMD [ "systemctl", "start", "sshd" ]
#ENTRYPOINT [ "/bin/bash" ]
ENTRYPOINT ["/usr/sbin/init"]
EXPOSE 22