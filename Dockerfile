FROM alpine:3.6

ENV ALPINE_VERSION=3.6

# Install needed packages. Notes:
#   * nodejs: Node.js and NPM 
#   * nginx: Nginx
#   * Git: Git to store wiki-js documents
#   * Curl: Curl for downloads.
#   * nodejs-npm: Required for Wikijs install
#   * bash: Required for Wikijs install
#   * supervisor: Control starting of applications
#   * Mysql: Mysql server



ENV PACKAGES="\
  nodejs \
  nginx \
  git \
  curl \
  unzip \
  nodejs-npm \
  bash \
  supervisor \
  mysql \ 
"

RUN apk --update add --no-cache $PACKAGES  \
    && echo 

USER root
WORKDIR /root/

WORKDIR /var/www/
RUN mkdir -p ghost

RUN curl -sSLO https://github.com/TryGhost/Ghost/releases/download/0.11.4/Ghost-0.11.4.zip && \
    unzip ./*.zip -d ghost && \
    rm ./*.zip

RUN addgroup www-data
RUN adduser ghost -G www-data -S /bin/bash
RUN chown ghost:www-data .
RUN chown ghost:www-data ghost
RUN chown ghost:www-data -R ghost/*
RUN npm install -g pm2

USER ghost
WORKDIR /var/www/ghost
RUN npm install sqlite3
RUN npm install

EXPOSE 2368
EXPOSE 2369
RUN ls && pwd

ENV NODE_ENV production

RUN sed -e s/127.0.0.1/0.0.0.0/g ./config.example.js > ./config.js

VOLUME ["/var/www/ghost/content/apps"]
VOLUME ["/var/www/ghost/content/data"]
VOLUME ["/var/www/ghost/content/images"]

CMD ["pm2", "start", "index.js", "--name", "blog", "--no-daemon"]
