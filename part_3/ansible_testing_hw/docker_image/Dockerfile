FROM centos:7
ENV MOLECULE_NO_LOG false

RUN yum -y update
RUN yum -y install epel-release python3 python3-pip git openssh-server openssh-clients gcc make wget sudo vim java-1.8.0-openjdk
RUN yum -y install glibc-common tar zlib-devel openssl-devel libffi-devel
RUN yum -y install iptables supervisor
RUN yum clean all

ADD https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz Python-3.9.2.tgz
RUN tar xf Python-3.9.2.tgz && cd Python-3.9.2/ && ./configure && make && make altinstall
RUN python3 -m pip install --upgrade pip && pip3 install tox selinux
RUN rm -rf Python-*

ENV DOCKER_VERSION=20.10.11
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN set -eux; \
    curl -L https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o docker.tgz && \
    tar --extract \
        --file docker.tgz \
        --strip-components 1 \
        --directory /usr/local/bin && \
    rm docker.tgz

COPY config/docker.ini /etc/supervisord.d/
COPY startup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/startup.sh

ENTRYPOINT ["startup.sh"]
CMD ["sh"]