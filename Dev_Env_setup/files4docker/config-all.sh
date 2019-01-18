#!/bin/bash
hostname=$(hostname)

# Java
alternatives --install /usr/bin/java java /opt/jdk1.8.0_112/bin/java 2
alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_112/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_112/bin/javac 2
alternatives --set java /opt/jdk1.8.0_112/bin/java
alternatives --set jar /opt/jdk1.8.0_112/bin/jar
alternatives --set javac /opt/jdk1.8.0_112/bin/javac

# Phoenix
cp /opt/apache-phoenix-5.0.0-HBase-2.0-bin/phoenix-5.0.0-HBase-2.0-server.jar /opt/hbase-2.0.0/lib/

# NiFi change 8080 or any other number to 9090
sed -i 's/^nifi.web.http.port=[0-9]\{1,5\}$/nifi.web.http.port=9090/' /opt/nifi-1.7.0/conf/nifi.properties
cat >> /opt/nifi-1.7.0/conf/bootstrap.conf << EOF
java.arg.18=-Dcom.sun.management.jmxremote.local.only=false
java.arg.19=-Dcom.sun.management.jmxremote=true
java.arg.20=-Dcom.sun.management.jmxremote.authenticate=false
java.arg.21=-Dcom.sun.management.jmxremote.ssl=false
java.arg.22=-Dcom.sun.management.jmxremote.port=40004
java.arg.23=-Dcom.sun.management.jmxremote.rmi.port=40004
java.arg.24=-Djava.rmi.server.hostname=localhost
java.arg.25=-XX:+FlightRecorder
java.arg.26=-XX:+UnlockCommercialFeatures
EOF

# Kafka change 9092 or any other number to 6667
sed -i "s%^#\?listeners=PLAINTEXT://.*:[0-9]\{1,5\}$%listeners=PLAINTEXT://$hostname:6667%" /opt/kafka_2.11-1.1.1/config/server.properties

if [ ! -f /opt/kafka_2.11-1.1.1/bin/kafka-run-class.sh.backup ]
then
    cp /opt/kafka_2.11-1.1.1/bin/kafka-run-class.sh /opt/kafka_2.11-1.1.1/bin/kafka-run-class.sh.backup
fi
sed -i '/KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -Dcom.sun.management.jmxremote.port=$JMX_PORT "/a \  KAFKA_JMX_OPTS="$KAFKA_JMX_OPTS -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote.rmi.port=$JMX_PORT "' /opt/kafka_2.11-1.1.1/bin/kafka-run-class.sh

# HBase
mkdir /opt/hbase-2.0.0/lib/native
ln -s /opt/hadoop-3.1.1/lib/native /opt/hbase-2.0.0/lib/native/Linux-amd64-64
cat > /opt/hbase-2.0.0/conf/hbase-site.xml << EOF
<configuration>
  <property>
    <name>hbase.rootdir</name>
    <value>file:///home/testuser/hbase</value>
  </property>
  <property>
    <name>hbase.zookeeper.property.dataDir</name>
    <value>/home/testuser/zookeeper</value>
  </property>
  <property>
    <name>hbase.unsafe.stream.capability.enforce</name>
    <value>false</value>
    <description>
      Controls whether HBase will check for stream capabilities (hflush/hsync).

      Disable this if you intend to run on LocalFileSystem, denoted by a rootdir
      with the 'file://' scheme, but be mindful of the NOTE below.

      WARNING: Setting this to false blinds you to potential data loss and
      inconsistent system state in the event of process and/or node failures. If
      HBase is complaining of an inability to use hsync or hflush it's most
      likely not a false positive.
    </description>
  </property>
  <property>
    <name>hbase.defaults.for.version.skip</name>
    <value>true</value>
  </property>
  <property>
    <name>hbase.regionserver.wal.codec</name>
    <value>org.apache.hadoop.hbase.regionserver.wal.IndexedWALEditCodec</value>
  </property>
  <property>
    <name>hbase.region.server.rpc.scheduler.factory.class</name>
    <value>org.apache.hadoop.hbase.ipc.PhoenixRpcSchedulerFactory</value>
    <description>Factory to create the Phoenix RPC Scheduler that uses separate queues for index and metadata updates</description>
  </property>
  <property>
    <name>hbase.rpc.controllerfactory.class</name>
    <value>org.apache.hadoop.hbase.ipc.controller.ServerRpcControllerFactory</value>
    <description>Factory to create the Phoenix RPC Scheduler that uses separate queues for index and metadata updates</description>
  </property>
  <property>
    <name>phoenix.functions.allowUserDefinedFunctions</name>
    <value>true</value>
    <description>enable UDF functions</description>
  </property>
</configuration>
EOF

if [ ! -f /opt/hbase-2.0.0/conf/hbase-env.sh.backup ]
then
    cp /opt/hbase-2.0.0/conf/hbase-env.sh /opt/hbase-2.0.0/conf/hbase-env.sh.backup
fi
sed -i 's/^# export HBASE_JMX_BASE=.*$/export HBASE_JMX_BASE="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -XX:+UnlockCommercialFeatures -XX:+FlightRecorder -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.local.only=false -Djava.rmi.server.hostname=localhost"/' /opt/hbase-2.0.0/conf/hbase-env.sh
sed -i 's/^# export HBASE_MASTER_OPTS="$HBASE_MASTER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10101"$/export HBASE_MASTER_OPTS="$HBASE_MASTER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=40006 -Dcom.sun.management.jmxremote.rmi.port=40006"/' /opt/hbase-2.0.0/conf/hbase-env.sh
#sed -i 's/^# export HBASE_REGIONSERVER_OPTS="$HBASE_REGIONSERVER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10102"$/export HBASE_REGIONSERVER_OPTS="$HBASE_REGIONSERVER_OPTS $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=40007 -Dcom.sun.management.jmxremote.rmi.port=40007"/' /opt/hbase-2.0.0/conf/hbase-env.sh

# Cassandra
sed -i "s/- seeds: \".*\"$/- seeds: \"$(hostname -i)\"/" /opt/apache-cassandra-3.11.3/conf/cassandra.yaml
sed -i "s/^listen_address: .*$/listen_address: $hostname/" /opt/apache-cassandra-3.11.3/conf/cassandra.yaml
sed -i "s/^rpc_address: .*$/rpc_address: $hostname/" /opt/apache-cassandra-3.11.3/conf/cassandra.yaml

if [ ! -f /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh.backup ]
then
    cp /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh.backup
fi
echo 'JVM_OPTS="$JVM_OPTS -XX:+UnlockCommercialFeatures -XX:+FlightRecorder"' >> /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh
sed -i 's/^# JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=.*"$/JVM_OPTS="$JVM_OPTS -Djava.rmi.server.hostname=localhost"/' /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh
sed -i "s/LOCAL_JMX=yes$/LOCAL_JMX=no/" /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh
sed -i 's/^JMX_PORT="7199"$/JMX_PORT="40011"/' /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh
sed -i 's/JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=true"$/JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.authenticate=false"/' /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh
sed -i 's/#JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl=true"$/JVM_OPTS="$JVM_OPTS -Dcom.sun.management.jmxremote.ssl=false"/' /opt/apache-cassandra-3.11.3/conf/cassandra-env.sh

# Spark
cp /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties.template /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties
sed -i '/*.sink.jmx.class=org.apache.spark.metrics.sink.JmxSink/s/^#//' /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties
sed -i '/master.source.jvm.class=org.apache.spark.metrics.source.JvmSource/s/^#//' /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties
sed -i '/worker.source.jvm.class=org.apache.spark.metrics.source.JvmSource/s/^#//' /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties
sed -i '/driver.source.jvm.class=org.apache.spark.metrics.source.JvmSource/s/^#//' /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties
sed -i '/executor.source.jvm.class=org.apache.spark.metrics.source.JvmSource/s/^#//' /opt/spark-2.3.1-bin-hadoop2.7/conf/metrics.properties
