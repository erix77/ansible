#! /bin/bash
#
# => firewall-cmd --get-service
#RH-Satellite-6 RH-Satellite-6-capsule amanda-client amanda-k5-client amqp amqps apcupsd audit bacula bacula-client bgp 
#bitcoin bitcoin-rpc bitcoin-testnet bitcoin-testnet-rpc ceph ceph-mon cfengine condor-collector...
#
# Comment identifier le N° de port d'un service ?
#
# => firewall-cmd --info-service=samba
#samba
#  ports: 137/udp 138/udp 139/tcp 445/tcp
#  protocols:
#  source-ports:
#  modules: netbios-ns
#  destination:
#
for service in $(firewall-cmd --get-service)
do
  echo -n "${service} ="
  firewall-cmd --info-service=${service} | grep " ports" | awk '{ gsub(/ports:/,""); print $0}'
done
