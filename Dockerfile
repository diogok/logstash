FROM diogok/elasticsearch

WORKDIR /opt

RUN curl -L 'https://download.elastic.co/kibana/kibana/kibana-4.5.0-linux-x64.tar.gz' -o kibana.tar.gz && \
    tar -xvf kibana.tar.gz && \
    mv kibana-4.5.0-linux-x64 kibana && \
    rm kibana.tar.gz

RUN curl https://download.elastic.co/logstash/logstash/logstash-all-plugins-2.3.1.tar.gz \
    --insecure -o logstash-2.3.1.tar.gz && \ 
    tar -xvf logstash-2.3.1.tar.gz && \
    mv logstash-2.3.1 logstash && \
    rm logstash-2.3.1.tar.gz

RUN sed -i -e 's/docker_es/logstash_es/' /usr/share/elasticsearch/config/elasticsearch.yml

EXPOSE 5601
EXPOSE 9514
EXPOSE 9200
EXPOSE 12201

COPY kibana.yml /opt/kibana/config/kibana.yml
COPY logstash.conf /opt/logstash.conf

COPY start.sh /opt/start.sh
CMD ["/opt/start.sh"]

