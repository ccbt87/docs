#!/bin/bash
echo ">>>>>>>>>> Script begin <<<<<<<<<<"
export JAVA_HOME=/opt/jdk1.8.0_112
export PATH=$JAVA_HOME/bin:$PATH

# Kill Cassandra
echo "> Cassandra stopping"
pkill -f cassandra
echo "> Cassandra stopped"

# Stop Kafka
echo "> Kafka stopping"
/opt/kafka_2.11-1.1.1/bin/kafka-server-stop.sh
#/opt/kafka_2.11-1.1.1/bin/zookeeper-server-stop.sh
echo "> Kafka stopped"

# Stop HBase with Zookeeper
echo "> HBase stopping"
/opt/hbase-2.0.0/bin/stop-hbase.sh
echo "> HBase stopped"

# Stop Spark
echo "> Spark stopping"
/opt/spark-2.3.1-bin-hadoop2.7/sbin/stop-slave.sh
/opt/spark-2.3.1-bin-hadoop2.7/sbin/stop-master.sh
echo "> Spark stopped"

# Stop NiFi
echo "> NiFi stopping"
/opt/nifi-1.7.0/bin/nifi.sh stop
echo "> NiFi stopped"

echo ">>>>>>>>>> Script end <<<<<<<<<<"
