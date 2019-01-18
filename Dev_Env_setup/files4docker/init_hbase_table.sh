#!/bin/bash
table=tenantid_data
cfstr=", 'e', 'U', 'S'"

if [ $# -eq 1 ]
then
  table=$1
  echo -e "disable '$table'\ndrop '$table'" | /opt/hbase-2.0.0/bin/hbase shell
elif [ $# -gt 1 ]
then
  table=$1
  shift
  columnfamilies=( $@ )
  cfstr=$(printf ", '%s'" "${columnfamilies[@]}")
  echo -e "disable '$table'\ndrop '$table'\ncreate '$table'$cfstr" | /opt/hbase-2.0.0/bin/hbase shell
else
  echo -e "disable '$table'\ndrop '$table'\ncreate '$table'$cfstr" | /opt/hbase-2.0.0/bin/hbase shell
fi
