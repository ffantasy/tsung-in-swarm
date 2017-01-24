#Tsung In Docker Swarm
#base on ubuntu
FROM ubuntu:16.04
MAINTAINER FFantasy <qwertxp@gmail.com>

#prepare
WORKDIR "/root"
RUN	apt-get update
RUN apt-get -y install wget
RUN apt-get -y install make

#install tsung 1.6.0
RUN apt-get -y install erlang gnuplot libtemplate-perl
RUN wget http://tsung.erlang-projects.org/dist/tsung-1.6.0.tar.gz
RUN tar zxvf tsung-1.6.0.tar.gz
RUN cd tsung-1.6.0 && ./configure && make && make install && make clean

#install ssh
RUN apt -y install ssh
RUN ssh-keygen -f /root/.ssh/id_rsa -N "" -t rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN echo "LogLevel ERROR" >> /etc/ssh/ssh_config

#clean
RUN apt-get clean
RUN rm -rf /root/*

#add script file
ADD runcontroler.sh /root/
ADD runclient.sh /root/
