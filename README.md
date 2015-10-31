Files
deploy-servers is the driver file that runs the other scripts 
to start goapp and python app.
Note: I only implemented two server apps go an python
How to run the script
[avsingh@dev-mdbs-db2-p1 challenge]$ ./deploy-servers
Choose Action?
1) Rollout goapp
2) Rollout python App
3) Rollout lua app
#?

deploy-servers - runs the overall deployment
goap_starter.sh - starts goapp on a server, this is called from deploy-server script for each host
python_app_starter.sh - starts python app on a simple python server
simple.py - simple python app
find_new_port.py - helper python file to get open ports
hosts - hostname or ip address of all the servers on which you would like to run the servers on
challenge suggested to pretend a method to return hostnames `./gethostname go-server`, to actually implement
the solution I just used a hosts with ipaddress in it.

