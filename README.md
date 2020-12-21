
# Navigation platform

Service platform to execute navigation scripts automatically every 10 minutes, store time responses data in a database, visualize the metrics and alert if an error occurs.

All this services were deployed in navigation namespace. To deploy them, you have to execute:

```bash
kubectl create -f service-folder/.
```

Next, we will explain all the service deployed:

## InfluxDB

Timeseries database that stores all the metrics send by navigation scripts. It stores navigation step as measurement and time response for each step as value.

To generate data to create database and authentication you can execute bash script **secret-influxdb.sh** before creating the rest of resources.

This service is exposed in 8086 port internally.

## Jenkins

CI/CD tool that works as cron executor of navigation scripts, sending alerts if scripts failed.

This service is exposed in 8080 port externally.

Jenkins architecture is master-slave, so this instance is the principal and Web UI to interact to schedule the jobs, manage configuration, install plugins, configure nodes and more.

Also, we need a slave instance that will execute the jobs and it will send the result to master instance.

## Jenkins Agent

Jenkins slave that executes the jobs that master instance sends. This agent is build over ssh linux agent image. This agent has jdk-java and ssh service to communicate with it. Also, it has python script dependencies like python and python modules written in requirements.txt file.

Docker image has to be built with Private Docker Registry configuration.
```bash
# Generate image in local Docker environment
docker build -t 192.168.205.10:5000/jenkins-agent:jdk11 jenkins-agent/.
# Push to private registry
docker push 192.168.205.10:5000/jenkins-agent:jdk11
```

This service is exposed in 22 port internally.
