# ELK-Salt
A Salt State for installing the Elasticsearch / Logstash / Kibana stack.

![] (http://www.rittmanmead.com/wp-content/uploads/2014/11/kib28.png)

```Work on Debian Jessie```, and maybe on other distros

```ElasticSearch 1.4```
```Logstash 1.5```
```Kibana 4.02```

This State provide ELK Stack for using REDIS as a Brocker.

You just have to ship your logs to REDIS using Beaver (for example).

https://github.com/josegonzalez/python-beaver

You can install Redis-Server using the redis formulas :

https://github.com/saltstack-formulas/redis-formula
