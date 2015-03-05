# Logstash Container

Contains a local ElasticSearch, Logstash with Syslog input and Kibana with proper proxy.

Run it:

    $ docker run -d -P --name logstash diogok/logstash

See where it is binding the syslog port:

    $ LOGSTASH=$(docker inspect --format='localhost:{{(index (index .NetworkSettings.Ports "9514/tcp") 0).HostPort}}' logstash)

Configure your rsyslog to log to it:

    $ echo "*.* @@$LOGSTASH" > /etc/rsyslog.d/50-logstash.conf

See where it is running the web:

    $ docker inspect --format='http://localhost:{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' logstash
  
Log to the container:

    $ logger "Hello"

Integrate with logspout to log all docker containers stdout and stderr to logstash:

    $ docker run -d --name logspout --link logstash:logastash -v=/var/run/docker.sock:/tmp/docker.sock progrium/logspout syslog://logstash:9514

License: MIT.

