#!/bin/bash
table=test-table
columnfamily=word-count

if [ $# -eq 1 ]
then
  table=$1
  echo -e "disable '$table'\ndrop '$table'" | /opt/hbase-2.0.0/bin/hbase shell
elif [ $# -eq 2 ]
then
  table=$1
  columnfamily=$2
  echo -e "disable '$table'\ndrop '$table'\ncreate '$table', '$columnfamily'" | /opt/hbase-2.0.0/bin/hbase shell
else
  echo -e "disable '$table'\ndrop '$table'\ncreate '$table', '$columnfamily'" | /opt/hbase-2.0.0/bin/hbase shell
fi
