FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y 

# Install java 8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default 

# Install Logstash
RUN cd /root && \
    wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz --no-check-certificate && \
    tar -xzf logstash-1.4.2.tar.gz && \
    rm -rf logstash-1.4.2.tar.gz 

# Install ElasticSearch
RUN cd /root && \
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.tar.gz && \
    tar -xzf elasticsearch-1.4.0.tar.gz && \
    rm elasticsearch-1.4.0.tar.gz

# Install Kibana
RUN cd /root && \
    wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.2.tar.gz && \
    tar -xzf kibana-3.1.2.tar.gz && \
    mv kibana-3.1.2 /var/www && \
    rm kibana-3.1.2.tar.gz 

# Install nginx and supervisor
RUN apt-get install -y nginx supervisor
RUN mkdir /var/log/supervisord 

# Add Config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisor.conf /etc/supervisor/conf.d/logstash.conf
ADD config.js /var/www/config.js
ADD logstash.conf /root/logstash-1.4.2/logstash.conf

# Expose SYSLOG, supervisord and Nginx/Kibana 
EXPOSE 9514
EXPOSE 9001
EXPOSE 80

# Start supervisor
CMD ["supervisord"]

