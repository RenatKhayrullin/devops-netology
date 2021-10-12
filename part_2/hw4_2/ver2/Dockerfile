FROM ubuntu:latest

ENV TZ "Europe/Moscow"
ENV DEBIAN_FRONTEND=noninteractive

# установил самым "тупым" способом
# размер docker образа из-за этого получился слишком большим
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get install -y wget && \
    apt-get install -y tzdata && \
    apt-get install -y openjdk-11-jre

# быстро не смог найти альтернативу установки кроме, как через apt-get install -y jenkins
# для docker образа такой вид установки, избыточен, т.к. прописывается jenkins в /etc/default
RUN add-apt-repository universe && \
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add - && \
    sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
    apt-get update && \
    apt-get install -y jenkins

EXPOSE 8080

ENTRYPOINT exec java -jar /usr/share/jenkins/jenkins.war