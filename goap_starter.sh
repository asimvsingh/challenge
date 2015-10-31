#!/bin/bash

if [ $# -ne 1 ]; then 
  echo "wrong number of agruments"
  echo "Usage: goapp_starter.sh <host_name>"
  exit 1
fi

#generate new ports for starting the server
admin_port=`python /home/avsingh/challenge/find_new_port.py`
app_port=`python /home/avsingh/challenge/find_new_port.py`

#start the server, also dump the access log, there could be a better way of
#naming and identifying the log file, may pass in version of the app as argument
#cd /home/avsingh/goaap/go_appengine 
/home/avsingh/goaap/go_appengine/goapp serve -host=$1 -admin_port=$admin_port -port=$app_port /home/avsingh/challenge/go_app_prod/ > /tmp/go_app_prod_$app_port.log  2>&1 &
#check if the server started up ok

# to be safe also check if the server started up
var=`ps -ef | grep -v grep | grep "port=$app_port"`
if [[ $var ]]; then
  echo "goapp server started successfully on port $app_port"
else
  echo -e  "goaap server startup failed on port $app_port \\nLast 5 lines of the log file" 
  tail -5 /tmp/go_app_prod.log
  exit 1
fi  

#make the application available on port 8080
/home/avsingh/challenge/port_redirect.sh 8080 $app_port
