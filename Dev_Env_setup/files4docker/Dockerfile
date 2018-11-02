FROM centos

# extract cassandra, kafka, and spark
ADD apache-cassandra-3.11.3-bin.tar.gz /opt
ADD kafka_2.11-1.1.1.tgz /opt
ADD spark-2.3.1-bin-hadoop2.7.tgz /opt
ADD hbase-2.0.0-bin.tar.gz /opt
ADD nifi-1.7.0-bin.tar.gz /opt

# Centos image has Python 2.7.5 pre-installed, install JDK 8
# OpenJDK
#RUN yum install java-1.8.0-openjdk-devel -y
#ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64
# Oracle JDK
ADD jdk-8u112-linux-x64.tar.gz /opt
ENV JAVA_HOME /opt/jdk1.8.0_112
ENV PATH "$JAVA_HOME/bin:$PATH"
RUN alternatives --install /usr/bin/java java /opt/jdk1.8.0_112/bin/java 2
RUN alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_112/bin/jar 2
RUN alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_112/bin/javac 2
RUN alternatives --set java /opt/jdk1.8.0_112/bin/java
RUN alternatives --set jar /opt/jdk1.8.0_112/bin/jar
RUN alternatives --set javac /opt/jdk1.8.0_112/bin/javac

# copy scripts for staring and stopping cassandra, kafka, and spark
COPY stop-all.sh /root
COPY start-all.sh /root
COPY config-all.sh /root
COPY init_hbase_table.sh /root

# expose ports
EXPOSE 2181 4040 6667 7077 8080 8081 8086 9042 9090 16000 16010 16020 16030 18080

WORKDIR /root

# start cassandra, kafka, and spark
CMD /root/config-all.sh && /root/start-all.sh && /bin/bash
