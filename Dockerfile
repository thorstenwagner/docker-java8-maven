# CentOS 7
# Oracle Java 1.8.0_101 64 bit
# Maven 3.3.9

FROM centos:centos7

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

# this is a non-interactive automated build - avoid some warning messages
ENV CENTOS_FRONTEND noninteractive

# update repositories
RUN yum update 

# install wget
RUN yum install wget which java-1.8.0-openjdk-devel xorg-x11-server-Xvfb firefox -y

#Setup Xvfb
RUN Xvfb :99 &
RUN export DISPLAY=:99

# get maven 3.3.9
RUN wget --no-verbose -O /tmp/apache-maven-3.3.9.tar.gz http://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

# verify checksum
RUN echo "516923b3955b6035ba6b0a5b031fbd8b /tmp/apache-maven-3.3.9.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.3.9.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.3.9 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.3.9.tar.gz
ENV MAVEN_HOME /opt/maven

# remove download archive files
RUN yum clean all
