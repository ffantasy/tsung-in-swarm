# tsung-in-swarm

Easy to use tsung testing in distributed mode.

**Step 1**, Create docker swarm  
Use beblow command(assume you have a host and ip is 192.168.0.10):
```Shell
# docker swarm init --advertise-addr 192.168.0.10
```
More info: https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/

**Step 2**, Create your tsung test config file.  
Here a example file: https://github.com/ffantasy/tsung-in-swarm/blob/master/tsungConfig.xml      
*NOTICE*: Keep `<clients></clients>` and `<monitoring></monitoring>` node empty.  
More info: http://tsung.erlang-projects.org/user_manual/index.html

**Step 3**, Use script to start your test.  
```Shell
# ./tis.sh /home/root/tsungConfig.xml 2 0
```
The script takes 3 parameters, first parameter is absolute path to your tsung config file, second parameter indicate that how many clients would you like to run in your docker swarm, third parameter indicate that if tsung *WORKER* can be run on *CONTROLER* host, *0* for no, *1* for yes. this option help you ensure *WORKER* run on load generation host only.
Download script here: https://github.com/ffantasy/tsung-in-swarm/blob/master/tis.sh

**Step 4**, Check the test reports.   
Visit the url: http://192.168.0.10:8091

ALL DONE!
