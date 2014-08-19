# Logstash Container

Contains a local ElasticSearch, Logstash with Syslog input and Kibana with proper proxy.

Run it:

    $ docker run -d -P --name logstash -t diogok/logstash

See where it is binding the syslog port:

    $ LOGSTASH=$(docker inspect --format='localhost:{{(index (index .NetworkSettings.Ports "9514/tcp") 0).HostPort}}' logstash)

Configure your rsyslog to log to it:

    $ echo "*.* @@$LOGSTASH" > /etc/rsyslog.d/50-logstash.conf

See where it is running the web:

    $ docker inspect --format='http://localhost:{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' logstash
  
Log to the container:

    $ logger "Hello"

License: MIT.

