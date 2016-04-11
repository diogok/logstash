# Logstash Container

Contains a local ElasticSearch, Logstash with Syslog input and Kibana with proper proxy.

Run it:

    $ docker run -d -P --name logstash diogok/logstash

Check the ports:

    $ docker ps

Access kibana at port [http://localhost:5601](http://localhost:5601).

### Syslog/Rsyslog

Log to the container:

    $ logger -d -n 127.0.0.1 -P 9514 "Hello"

### Gelf and docker logs

Run your docker logs to logstash:

    docker run --log-driver=gelf --log-opt gelf-address=udp://127.0.0.1:12201 your/container

License: MIT.

