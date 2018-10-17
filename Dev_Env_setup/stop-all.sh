#!/bin/bash
echo "Script start"

# Kill Cassandra
echo "Stopping Cassandra"
pkill -f cassandra
echo "Cassandra stopped"

# Stop Kafka
echo "Stopping Kafka"
/opt/kafka_2.11-1.1.1/bin/kafka-server-stop.sh
#/opt/kafka_2.11-1.1.1/bin/zookeeper-server-stop.sh
echo "Kafka stopped"

# Stop HBase with Zookeeper
echo "Stopping HBase"
/opt/hbase-2.0.0/bin/stop-hbase.sh
echo "HBase stopped"

# Stop Spark
echo "Stopping Spark"
/opt/spark-2.3.1-bin-hadoop2.7/sbin/stop-slave.sh
/opt/spark-2.3.1-bin-hadoop2.7/sbin/stop-master.sh
echo "Spark stopped"

# Stop NiFi
echo "Stopping NiFi"
/opt/nifi-1.7.0/bin/nifi.sh stop
echo "NiFi stopped"

echo "Script end"
