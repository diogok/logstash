FROM dockerfile/java

# Install Logstash
RUN cd /root && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.0.tar.gz --no-check-certificate && \
    tar -xzf logstash-1.4.0.tar.gz && \
    rm -rf logstash-1.4.0.tar.gz 
ADD logstash.conf /root/logstash-1.4.0/logstash.conf

# Install ElasticSearch
RUN cd /root && \
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz && \
    tar -xzf elasticsearch-1.1.1.tar.gz && \
    rm elasticsearch-1.1.1.tar.gz

# Install Kibana
RUN cd /root && \
    wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz && \
    tar -xzf kibana-3.0.1.tar.gz && \
    mv kibana-3.0.1 /var/www && \
    rm kibana-3.0.1.tar.gz 
ADD config.js /var/www/config.js

# Install nginx and supervisor
RUN apt-get install -y nginx supervisor
RUN mkdir /var/log/supervisord 
ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisor.conf /etc/supervisor/conf.d/logstash.conf

# Expose ElasticSearch, SYSLOG and Nginx/Kibana 
EXPOSE 9200
EXPOSE 9514
EXPOSE 80

# Start supervisor
CMD ["supervisord"]

