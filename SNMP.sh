#!/bin/bash
read -p 'Chon IP Address Server VM: ' IP

apt-get update
apt-get install snmpd snmp

cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak

echo "Hoan tat cai dai va copy"

echo "agentAddress udp:$IP:161
view systemonly included .1.3.6.1.2.1.1
view systemonly included .1.3.6.1.2.1.25.1
rocommunity public
#rocommunity6 public default -V systemonly
rouser authOnlyUser
sysLocation ITDEPT
sysContact IT-ADMIN <loc.kdc@phuclong.com.vn>
sysServices 72
proc mountd
proc ntalkd 4
proc sendmail 10 1
disk / 10000
disk /var 5%
includeAllDisks 10%
load 12 10 5
trapsink localhost public
iquerySecName internalUser
rouser internalUser
defaultMonitors yes
linkUpDownNotifications yes
extend test1 /bin/echo Hello, world!
extend-sh test2 echo Hello, world! ; echo Hi there ; exit 35
master agentx" > /etc/snmp/snmpd.conf

echo "Hoan tat copy cau hinh file SNMPD"


cp /etc/snmp/snmp.conf /etc/snmp/snmp.conf.bak
echo "# As the snmp packages come without MIB files due to license reasons, loading
# of MIBs is disabled by default. If you added the MIBs you can reenable
# loading them by commenting out the following line.
#mibs :" > /etc/snmp/snmp.conf

echo "Hoan tat copy cau hinh file SNMP"

service snmpd stop
service snmpd start

echo "Hoan tat Start Services SNMP"
echo "Hoan tat cai dat cho server $IP"

service snmpd status

