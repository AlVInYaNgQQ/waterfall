FROM node:16

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY . .

RUN apt-get update \
    && npm install \
    && npm install @parrotjs/vue-waterfall -S

EXPOSE 15000

CMD ["node", "examples/server.js"]
