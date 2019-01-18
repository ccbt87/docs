#!/bin/bash
echo ">>>>>>>>>> Script begin <<<<<<<<<<"

# Start Cassandra
echo "> Cassandra starting"
/opt/apache-cassandra-3.11.3/bin/cassandra -R &> /dev/null
echo "> Cassandra started"

# Start HBase with Zookeeper
echo "> HBase starting"
/opt/hbase-2.0.0/bin/start-hbase.sh
echo "> HBase started"

# Start Phoenix Query Server
echo "> Phoenix Query Server starting"
/opt/apache-phoenix-5.0.0-HBase-2.0-bin/bin/queryserver.py start
echo "> Phoenix Query Server started"

# HBase running in standalone mode has the ZooKeeper server running already, there is no need to launch another ZooKeeper
#/opt/kafka_2.11-1.1.1/bin/zookeeper-server-start.sh -daemon /opt/kafka_2.11-1.1.1/config/zookeeper.properties
# Start Kafka
echo "> Kafka starting"
JMX_PORT=40005 /opt/kafka_2.11-1.1.1/bin/kafka-server-start.sh -daemon /opt/kafka_2.11-1.1.1/config/server.properties
echo "> Kafka started"

# Start NiFi
echo "> NiFi starting"
/opt/nifi-1.7.0/bin/nifi.sh start
echo "> NiFi started"

# Start Spark
echo "> Spark starting"
/opt/spark-2.3.1-bin-hadoop2.7/sbin/start-master.sh
/opt/spark-2.3.1-bin-hadoop2.7/sbin/start-slave.sh spark://$(hostname):7077
echo "> Spark started"

echo ">>>>>>>>>> Script end <<<<<<<<<<"
