#!/bin/bash

if [ $# -ne 1 ]; then
  echo "wrong number of agruments"
  echo "Usage: python_app_starter.sh <host_name>"
  exit 1
fi


hostname=$1
app_port=`python /home/avsingh/challenge/find_new_port.py`

#check to see if the python server is running
#if not then run the server first
var=`ps -ef | grep -v grep | grep -i "SimpleHTTPServer"`
if [[ $var ]]; then
  echo "python http server is runninng"
else
  echo "python server is not running starting python server"
       python -m SimpleHTTPServer 8000 > /tmp/python_server.log 2>&1 &
fi

#start the python app and pipe the output to file
#there could be a better way of naming and identifying the log,
#example user could pass in the version number of the app
/usr/bin/python2.6 /home/avsingh/challenge/simple.py $1 $app_port > /tmp/simple_$app_port.log  2>&1 &

#find the running process
var=`ps -ef | grep -v grep | grep "simple.py" | grep $app_port`
if [[ $var ]]; then
  echo "python app is runninng on port $app_port" 

else
  echo -e "python app did not start\\n please check the log  file /tmp/simple_$app.log"
  exit 1
fi

#make the application available on port 8080
/home/avsingh/challenge/port_redirect.sh 8081 $app_port
