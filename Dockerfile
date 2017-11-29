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
  mysql-client\
  mariadb-dev \
"

RUN apk --update add --no-cache $PACKAGES  \
    && echo 


EXPOSE 80
ENV NODE_ENV production

# Add files
ADD files/nginx.conf /etc/nginx/nginx.conf
ADD files/supervisord.conf /etc/supervisord.conf
ADD files/my.cnf /etc/mysql/my.cnf
ADD start.sh /

# Entrypoint
RUN chmod u+x /start.sh
CMD /start.sh
