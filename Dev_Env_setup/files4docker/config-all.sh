#!/bin/bash
hostname=$(hostname)

# NiFi change 8080 or any other number to 9090
sed -i 's/^nifi.web.http.port=[0-9]\{1,5\}$/nifi.web.http.port=9090/' /opt/nifi-1.7.0/conf/nifi.properties

# Kafka change 9092 or any other number to 6667
sed -i "s%^#\?listeners=PLAINTEXT://.*:[0-9]\{1,5\}$%listeners=PLAINTEXT://$hostname:6667%" /opt/kafka_2.11-1.1.1/config/server.properties

# HBase
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
</configuration>
EOF

# Cassandra
sed -i "s/^listen_address: .*$/listen_address: $hostname/" /opt/apache-cassandra-3.11.3/conf/cassandra.yaml
sed -i "s/^rpc_address: .*$/rpc_address: $hostname/" /opt/apache-cassandra-3.11.3/conf/cassandra.yaml
