FROM amazoncorretto:11

WORKDIR /home/jenkins

ADD https://get.jenkins.io/war/2.316/jenkins.war /home/jenkins

EXPOSE 8080

ENTRYPOINT exec java -jar jenkins.war