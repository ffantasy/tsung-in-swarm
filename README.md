# tsung-in-swarm

Easy to use tsung testing in distributed mode.

**Step 1**, Create docker swarm  
Use beblow command(assume your have a host and ip is 192.168.0.10):
```Shell
$ docker swarm init --advertise-addr 192.168.0.10
```
more info: https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/

**Step 2**, Create your tsung test config file.  
Here a example file: https://......   
*NOTICE*: Keep `<clients></clients>` and `<servers></servers>` node empty.  
More info: http://tsung.erlang-projects.org/user_manual/index.html

**Step 3**, Use script to start your test.  
```
$ ./tis.sh /home/root/config.xml 2
```
The script task 2 parameters, first parameter is absolute path to your tsung config file, second parameter indicate that how many clients would you like to run in your docker swarm.  
Download script here: https://github.com/ffantasy/tsung-in-swarm/blob/master/tis.sh

**Step 4**, Check the test reports.   
Visit the url: http://192.168.0.10:8091

ALL DONE!
