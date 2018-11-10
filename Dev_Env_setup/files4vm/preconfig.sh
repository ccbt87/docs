#!/bin/bash
# extract cassandra, kafka, and spark
tar zxf apache-cassandra-3.11.3-bin.tar.gz -C /opt
tar zxf kafka_2.11-1.1.1.tgz -C /opt
tar zxf spark-2.3.1-bin-hadoop2.7.tgz -C /opt
tar zxf hbase-2.0.0-bin.tar.gz -C /opt
tar zxf nifi-1.7.0-bin.tar.gz -C /opt

# Centos 7.5 has Python 2.7.5 pre-installed, install JDK 8
# OpenJDK
#yum install java-1.8.0-openjdk-devel -y
#export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64
# Oracle JDK
tar zxf jdk-8u112-linux-x64.tar.gz -C /opt
export JAVA_HOME=/opt/jdk1.8.0_112
export PATH=$JAVA_HOME/bin:$PATH
alternatives --install /usr/bin/java java /opt/jdk1.8.0_112/bin/java 2
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_112/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_112/bin/javac 2
alternatives --set java /opt/jdk1.8.0_112/bin/java
alternatives --set jar /opt/jdk1.8.0_112/bin/jar
alternatives --set javac /opt/jdk1.8.0_112/bin/javac
