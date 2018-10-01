#!/usr/bin/env bash

if [ $# -ne 2 ]
then
  echo "Usage: $0 hostname roCommunityString"
  exit 1
fi

set -x

snmpwalk -c $2 -v2c $1
snmpget -c $2 -v2c $1 'NET-SNMP-EXTEND-MIB::nsExtendOutLine."linux".1'

exit 0
