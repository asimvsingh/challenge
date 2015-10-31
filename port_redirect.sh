#!/bin/bash
constant_port=$1
app_port=$2
#delete exsiting redirection/forwarding
for i in `sudo iptables -t nat -L PREROUTING -n --line-numbers | grep $constant_port | awk -F" " '{print $1}'`
do
  echo "executing: sudo iptables -t nat  -D PREROUTING $i"
  sudo iptables -t nat  -D PREROUTING $i
done

sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport $constant_port -m state --state NEW -j REDIRECT --to-port $app_port  || (echo "ERROR: redirect $constant_port to $app_port failed" ; exit 1)
#open the traffic on the $app_port
sudo iptables -A INPUT -p tcp -m tcp --dport $app_port -j ACCEPT
echo "Dump the new redirect rules"
sudo iptables -t nat -L PREROUTING -n --line-numbers
exit 0
