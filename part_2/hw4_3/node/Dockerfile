FROM node:latest

WORKDIR /home/node_app

RUN git clone https://github.com/simplicitesoftware/nodejs-demo.git

WORKDIR /home/node_app/nodejs-demo

RUN npm install

ENV VCAP_APP_HOST 0.0.0.0

EXPOSE 3000

ENTRYPOINT exec node app.js