#!/bin/sh
rm /home/hansight/run/nta.pid -f
rm /dev/mqueue/hipc* -f
pkill oracle_parser
pkill pop3_parser
exec /opt/hansight/nta/bin/nta -k none --af-packet -l /tmp/nta --pidfile /home/hansight/run/nta.pid
