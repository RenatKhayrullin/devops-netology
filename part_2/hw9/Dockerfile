FROM centos:7

RUN yum -y update && \
    yum install -y wget && \
    yum install -y perl-Digest-SHA && \
    yum clean all

RUN groupadd -g 1000 elasticsearch && \
    adduser -u 1000 -g 1000 -d /home/elastic elasticsearch && \
    mkdir -p /var/lib/elasticsearch /var/log/elasticsearch && \
    chown elasticsearch:elasticsearch /var/lib/elasticsearch && \
    chown elasticsearch:elasticsearch /var/log/elasticsearch

WORKDIR /home/elastic
USER elasticsearch

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.1-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.1-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-7.15.1-linux-x86_64.tar.gz.sha512  && \
    tar -xzf elasticsearch-7.15.1-linux-x86_64.tar.gz && \
    rm elasticsearch-7.15.1-linux-x86_64.tar.gz && \
    rm elasticsearch-7.15.1-linux-x86_64.tar.gz.sha512

ENV ES_HOME="/home/elastic/elasticsearch-7.15.1"
ENV PATH="$ES_HOME/bin:$PATH"

EXPOSE 9200

ENTRYPOINT elasticsearch \
            # у меня не так много ресурсов на машине, поэтому в single-node режиме
            -Ecluster.name=netology_cluster \
            -Enode.name=netology_test \
            -Enetwork.host=0.0.0.0 \
            -Epath.data=/var/lib/elasticsearch \
            -Epath.logs=/var/log/elasticsearch \
            -Ediscovery.type=single-node