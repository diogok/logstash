#!/bin/bash

chown elasticsearch.elasticsearch $ES_HOME -R
su -p -s /bin/bash -c "$ES_HOME/bin/elasticsearch" elasticsearch &
sleep 10

/opt/logstash/bin/logstash agent -f logstash.conf &

[[ "$BASE" != "" ]] && echo server.basePath: /$BASE >> /opt/kibana/config/kibana.yml

/opt/kibana/bin/kibana

