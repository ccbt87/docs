#!/bin/bash
echo ">>>>>>>>>> Script begin <<<<<<<<<<"

# Kill Cassandra
echo "> Cassandra stopping"
pkill -f cassandra
echo "> Cassandra stopped"

# Stop Kafka
echo "> Kafka stopping"
/opt/kafka_2.11-1.1.1/bin/kafka-server-stop.sh
#/opt/kafka_2.11-1.1.1/bin/zookeeper-server-stop.sh
echo "> Kafka stopped"

# Stop NiFi
echo "> NiFi stopping"
/opt/nifi-1.7.0/bin/nifi.sh stop
echo "> NiFi stopped"

# Stop Phoenix Query Server
echo "> Phoenix Query Server stopping"
/opt/apache-phoenix-5.0.0-HBase-2.0-bin/bin/queryserver.py stop
echo "> Phoenix Query Server stopped"

# Stop HBase with Zookeeper
echo "> HBase stopping"
/opt/hbase-2.0.0/bin/stop-hbase.sh
echo "> HBase stopped"

# Stop Spark
echo "> Spark stopping"
/opt/spark-2.3.1-bin-hadoop2.7/sbin/stop-slave.sh
/opt/spark-2.3.1-bin-hadoop2.7/sbin/stop-master.sh
echo "> Spark stopped"

echo ">>>>>>>>>> Script end <<<<<<<<<<"
