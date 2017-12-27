#Tsung In Docker Swarm
#base on alpine
FROM alpine:3.6
MAINTAINER FFantasy <https://github.com/ffantasy>

#prepare
WORKDIR "/root"
RUN apk add -q --no-cache bash gnuplot make perl perl-template-toolkit
RUN apk add -q --no-cache erlang erlang-asn1 erlang-crypto erlang-dev erlang-inets erlang-os-mon erlang-public-key erlang-sasl erlang-ssl erlang-xmerl

#install tsung 1.7.0
RUN wget http://tsung.erlang-projects.org/dist/tsung-1.7.0.tar.gz
RUN tar zxvf tsung-1.7.0.tar.gz
RUN cd tsung-1.7.0 && ./configure && make -s && make install && make clean

#config ssh
RUN apk add -q --no-cache openssh
RUN ssh-keygen -A
RUN ssh-keygen -f /root/.ssh/id_rsa -N "" -t rsa
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN echo "LogLevel ERROR" >> /etc/ssh/ssh_config

#clean
RUN rm -rf /root/*

#add script file
ADD runcontroler.sh /root/
ADD runclient.sh /root/

