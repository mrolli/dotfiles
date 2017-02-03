#!/bin/bash

sudo sysctl -w net.inet.tcp.mssdflt=1460 
sudo sysctl -w net.inet.tcp.sendspace=262144 
sudo sysctl -w net.inet.tcp.recvspace=262144 
sudo sysctl -w net.inet.udp.recvspace=74848
sudo sysctl -w net.inet.udp.maxdgram=65535
sudo sysctl -w net.inet.tcp.rfc1323=1 
sudo sysctl -w net.inet.tcp.newreno=1 
sudo sysctl -w net.inet.tcp.always_keepalive=1 
sudo sysctl -w net.inet.tcp.keepidle=3600 
sudo sysctl -w net.inet.tcp.keepintvl=150 
sudo sysctl -w net.inet.tcp.slowstart_flightsize=4
sudo sysctl -w net.inet.tcp.strict_rfc1948=1
sudo sysctl -w net.inet.tcp.delayed_ack=1

#net.inet.tcp.mssdflt: 512 -> 1460
#net.inet.tcp.sendspace: 131072 -> 262144
#net.inet.tcp.recvspace: 131072 -> 262144
#net.inet.udp.recvspace: 196724 -> 74848
#net.inet.udp.maxdgram: 9216 -> 65535
#net.inet.tcp.rfc1323: 1 -> 1
#net: class is not implemented
#net.inet.tcp.always_keepalive: 0 -> 1
#net.inet.tcp.keepidle: 7200000 -> 3600
#net.inet.tcp.keepintvl: 75000 -> 150
#net.inet.tcp.slowstart_flightsize: 1 -> 4
#net.inet.tcp.strict_rfc1948: 0 -> 1
#net.inet.tcp.delayed_ack: 0 -> 1
